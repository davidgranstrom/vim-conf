--- @file lua/statusline.lua
--- @author David Granström
--- @license GPLv3

local M = {}

local glyphs = {
  branch = 'שׂ',
  moon = '',
  divider = '│',
}

--- Utils

local path_sep = vim.loop.os_uname().sysname == 'Windows' and '\\' or '/'

local function get_ft()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
  return ft
end

local function get_rel_filename()
  local buf = vim.api.nvim_get_current_buf()
  local name = vim.api.nvim_buf_get_name(buf)
  local cwd = vim.call('getcwd') .. path_sep
  local home = os.getenv('HOME')
  name = name:gsub(vim.pesc(cwd), '') -- escape magic chars
  name = name:gsub(home, '~')
  return name ~= '' and name or '[No name]'
end

local function get_gitbranch()
  local status, res = pcall(vim.call, 'FugitiveHead')
  return status and res or ''
end

local function pad(s, left, right)
  left = left or 0
  right = right or 0
  return string.rep(' ', left) .. s .. string.rep(' ', right)
end

local function short_path(path, keep)
  local max_len = 30
  if keep == 1 then
    return path
  end
  local len = string.len(path)
  if len > max_len then
    local s = ''
    local items = vim.split(path, path_sep)
    for i, item in ipairs(items) do
      if i ~= #items then
        s = s .. item:sub(1,keep) .. path_sep
      else
        s = s .. item
      end
    end
    path = s
    -- recurse if we're still above max_len
    if string.len(path) > max_len then
      return short_path(path, keep - 1)
    end
  end
  return path
end

--- Statusline

local function active_left()
  local gitbranch = get_gitbranch()
  local path = short_path(get_rel_filename(), 3)
  local ft = get_ft()
  local s = ''
  -- truncate at beginning of line
  s = s .. '%#StatusLine#'
  s = s .. '%<'
  -- filename
  if ft ~= 'help' then
    s = s .. path
  else
    s = s .. '%t'
  end
  -- git branch
  if gitbranch ~= '' then
    s = s .. pad(glyphs.branch, 1, 1) .. gitbranch
  end
  -- make integration
  s = s .. ' %{MakeBuildProgress()}'
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
  s = s .. '%#StatusLineNC#'
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
  return name ~= '' and name or '[No name]'
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
      s = s .. '%#TabLine#' .. pad(glyphs.divider, 1, 1)
    end
  end
  s = s .. '%#TabLineFill#'
  return s
end

--- Interface

function M.active()
  local stl = active_left() .. '=' .. active_right()
  vim.api.nvim_win_set_option(0, 'statusline', stl)
end

function M.inactive()
  local stl = inactive_left()
  vim.api.nvim_win_set_option(0, 'statusline', stl)
end

function M.tabline()
  return create_tabline()
end

return M
