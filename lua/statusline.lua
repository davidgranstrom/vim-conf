local M = {}

local function get_gitbranch()
  local status, res = pcall(vim.call, 'FugitiveHead')
  return status and res or ''
end

local function active_left()
  local gitbranch = get_gitbranch()
  local stl = ''
  -- relative path
  stl = stl .. '%<%f '
  -- git branch
  if gitbranch ~= '' then
    stl = stl .. '| ' .. gitbranch
  end
  -- help buffer flag, modified flag, read-only flag
  stl = stl .. ' %h%m%r%'
  return stl
end

local function active_right()
  local ft = vim.api.nvim_get_option('filetype')
  local stl = ''
  -- filetype
  stl = stl .. '%y '
  -- line num, virtual col, value of char (hex)
  stl = stl .. '%-8.(%l:%v %B%) '
  -- percentage through file
  stl = stl .. '%P'
  -- display scsynth status
  if ft == 'supercollider' then
    stl = stl ..' | %{scnvim#statusline#server_status()}'
  end
  return stl
end

local function inactive_left()
  return active_left()
end

local function inactive_right()
  return ''
end

function M.active()
  return active_left() .. '=' .. active_right()
end

function M.inactive()
  return inactive_left() .. '=' .. inactive_right()
end

return M
