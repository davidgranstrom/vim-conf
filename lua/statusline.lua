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
  stl = stl .. '%-10.(%l:%v %B%) '
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

--- Tabline

local function get_short_file_name(handle)
  local win = vim.api.nvim_tabpage_get_win(handle)
  local buf = vim.api.nvim_win_get_buf(win)
  local name = vim.api.nvim_buf_get_name(buf)
  name = vim.call('fnamemodify', name, ':p:t')
  return name == '' and 'No name' or name
end

local function create_tabline()
  local tabline = ''
  local tabs = vim.api.nvim_list_tabpages()
  local num_tabs = vim.call('tabpagenr', '$')
  for i, handle in ipairs(tabs) do
    local n = vim.call('tabpagenr')
    local name = get_short_file_name(handle)
    if i == n then
      tabline = tabline .. '%#TabLineSel#' .. name
    else
      tabline = tabline .. '%#TabLine#' .. name
    end
    if i ~= num_tabs then
      tabline = tabline .. ' | '
    end
  end
  return tabline
end

--- Interface

function M.active()
  return active_left() .. '=' .. active_right()
end

function M.inactive()
  return inactive_left() .. '=' .. inactive_right()
end

function M.my_tabline()
  return create_tabline()
end

return M
