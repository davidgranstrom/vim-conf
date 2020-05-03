--- @file lua/make.lua
--- @author David Granström
--- @brief Async make with quickfix integration
--- @license GPLv3

local M = {}
local uv = vim.loop
local on_exit_handlers = {}

--- Utils

local function print_err(msg)
  print('[make]:', msg)
end

local function add_to_cleanup(func)
  table.insert(on_exit_handlers, func)
end

local function find_git_root()
  local root = vim.call('system', 'git rev-parse --show-toplevel 2> /dev/null')
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

local function cleanup()
  for _,handler in ipairs(on_exit_handlers) do
    handler()
  end 
  on_exit_handlers = {}
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
    cwd = cwd
  }
  return uv.spawn('make', options, opts.on_exit)
end

local on_stderr = function(fd) 
  local s = ''
  uv.read_start(fd, function(err, data)
    assert(not err, err)
    if data then
      s = s .. data
    else
      -- reached EOF
      vim.schedule_wrap(function()
        vim.call('MakeQuickFix', s)
      end)()
    end
  end)
end

local on_stdout = function(fd) 
  uv.read_start(fd, function(err, data)
    assert(not err, err)
    if data then
      local progress = data:match('(%d+%%)')
      vim.schedule_wrap(function()
        vim.api.nvim_win_set_var(0, 'make_progress', progress)
      end)()
    end
  end)
end

local handle, pid;

function M.make()
  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)
  local on_exit = function(code, signal)
    stdout:close()
    stderr:close()
    handle:close()
  end

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

  on_stdout(stdout)
  on_stderr(stderr)
end

return M
