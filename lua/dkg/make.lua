--- @file lua/make.lua
--- @author David Granström
--- @brief Async make with quickfix integration
--- @license GPLv3

local M = {}
local uv = vim.loop
local stdout_log = ''

--- Utils

local function print_err(msg)
  print('[make]:', msg)
end

local function find_git_root()
  local root = vim.fn.system('git rev-parse --show-toplevel 2> /dev/null')
  if root ~= '' then
    root = root:gsub('\n', '')
  end
  return root
end

local function check_dir_exists(dir)
  local stat = uv.fs_stat(dir)
  if stat then
    return stat.type == 'directory'
  end
  return false
end

local function parse_build_progress(data)
  local progress, state = data:match('(%d+%%)%] (%a+)')
  if progress and state then
    local build = string.format('%s %s', state, progress)
    vim.api.nvim_win_set_var(0, 'make_progress', build)
  end
end

local function parse_ctest(data)
  local ctest_num = data:match('^%s*(%d+/%d+)')
  if ctest_num then
    local status = data:match('Passed') and 'Passed' or 'Failed'
    local ctest = string.format('%s %s', ctest_num, status)
    vim.api.nvim_win_set_var(0, 'make_progress', ctest)
  end
end

local function parse_ctest_fails(data)
  local index = data:find('The following tests FAILED:')
  if index then
    return data:sub(index)
  end
end

local function on_handle_exit(code)
  local msg = ''
  if code == 0 then
    msg = 'Build OK'
  else
    msg = 'Build ERR'
    local ctest_fails = parse_ctest_fails(stdout_log)
    if ctest_fails then
      vim.call('MakeQuickFix', ctest_fails)
    end
  end
  vim.api.nvim_win_set_var(0, 'make_progress', msg)
end

local function run_make(opts)
  local root = find_git_root()
  if root == '' then
    print_err('Not a git repo.')
    return nil, -1
  end

  local cwd = root .. '/build'

  local build_dir = check_dir_exists(cwd)
  if not build_dir then
    print_err('No build dir.')
    return nil, -1
  end

  local options = {
    stdio = {
      nil,
      opts.stdout,
      opts.stderr,
    },
    cwd = cwd,
    args = {'-j', 4}
  }
  return uv.spawn('make', options, vim.schedule_wrap(opts.on_exit))
end

--- Handlers

local on_stderr = function() 
  local s = ''
  return function(err, data)
    assert(not err, err)
    if data then
      s = s .. data
    else
      -- reached EOF
      vim.call('MakeQuickFix', s)
    end
  end
end

local on_stdout = function() 
  local s = ''
  return function(err, data)
    assert(not err, err)
    if data then
      s = s .. data
      -- save complete log
      stdout_log = stdout_log .. s
      local lines = vim.gsplit(s, '\n')
      for line in lines do
        if line ~= '' then
          parse_build_progress(line)
          parse_ctest(line)
        else
          s = ''
        end
      end
    end
  end
end

--- Interface

local handle, pid;

function M.make()
  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)

  local on_exit = function(code, signal)
    stdout:close()
    stderr:close()
    handle:close()
    on_handle_exit(code)
  end

  -- clear log
  stdout_log = ''

  handle, pid = run_make({
    stdout = stdout,
    stderr = stderr,
    on_exit = on_exit
  })

  if not handle then
    stdout:close()
    stderr:close()
    return
  end

  local onstdout = on_stdout() 
  local onstderr = on_stderr() 
  uv.read_start(stdout, vim.schedule_wrap(onstdout))
  uv.read_start(stderr, vim.schedule_wrap(onstderr))
end

return M
