local M = {}

local glyphs = {
  branch = '⎇ ',
  moon = '☾',
}

local function get_ft()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
  return ft
end

local function pad(s, left, right)
  left = left or 0
  right = right or 0
  return string.rep(' ', left) .. s .. string.rep(' ', right)
end

local function get_gitbranch()
  local status, res = pcall(vim.call, 'FugitiveHead')
  return status and res or ''
end

local function active_left()
  local gitbranch = get_gitbranch()
  local s = ''
  -- truncate at beginning of line
  s = s .. '%<'
  -- relative path
  s = s .. '%f'
  -- git branch
  if gitbranch ~= '' then
    s = s .. pad(glyphs.branch, 1) .. gitbranch
  end
  -- help buffer flag, modified flag, read-only flag
  s = s .. ' %h%m%r%'
  return s
end

local function active_right()
  local s = ''
  local ft = get_ft()
  -- line num, virtual col, value of char (hex)
  s = s .. '%-8.(%l:%v %B%)'
  s = s .. pad(glyphs.moon, 1, 1)
  -- display filetype (without brackets like %y)
  s = s .. ft
  -- overwrite the above and display scsynth server status
  if ft == 'supercollider' then
    s = '%(%l:%v %B%)'
    s = s .. pad(glyphs.moon, 2, 2)
    s = s .. '%{scnvim#statusline#server_status()}'
  end
  return s
end

local function inactive_left()
  local s = ''
  -- tail of filename path
  s = s .. '%t'
  return s
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
  local s = ''
  local tabs = vim.api.nvim_list_tabpages()
  local num_tabs = vim.call('tabpagenr', '$')
  for i, handle in ipairs(tabs) do
    local n = vim.call('tabpagenr')
    local name = get_short_file_name(handle)
    if i == n then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end
    s = s .. name
    if i ~= num_tabs then
      s = s .. '%#TabLine#' .. ' | '
    end
  end
  s = s .. '%#TabLineFill#'
  return s
end

--- Interface

function M.active()
  return active_left() .. '=' .. active_right()
end

function M.inactive()
  return inactive_left()
end

function M.my_tabline()
  return create_tabline()
end

return M
