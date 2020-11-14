--- @file lua/dkg/supercollider.lua
--- @author David Granström
--- @brief Custom sclang floating post window
--- @license GPLv3

local sclang = require'scnvim/sclang'
local api = vim.api
local M = {}

api.nvim_command([[
  autocmd FileType supercollider lua require'dkg/supercollider'.set_mappings()
]])

function M.is_valid()
  return M.bufnr and api.nvim_buf_is_loaded(M.bufnr) or false
end

function M.clear()
  if M.is_valid() then
    api.nvim_buf_set_lines(M.bufnr, 0, -1, true, {})
  end
end

function M.is_open()
  return M.is_valid() and vim.fn.bufwinnr(M.bufnr) > 0
end

function M.open()
  local win_height = api.nvim_get_option('lines')
  local win_width = api.nvim_get_option('columns')
  local opts = {
    relative = 'editor',
    focusable = true,
    width =  80,
    height = 20,
    col = win_width - 81,
    row = win_height - 23,
    anchor = 'NW',
    style = 'minimal',
  }
  local win = api.nvim_open_win(M.bufnr, false, opts)
  -- api.nvim_win_set_option(win, 'winhl', 'Normal:NormalFloat')
  api.nvim_win_set_option(win, 'winblend', 30)
  return win
end

function M.toggle()
  if M.is_open() then
    api.nvim_win_close(M.winnr, true)
  else
    M.winnr = M.open()
  end
end

function M.set_mappings()
  local options = { noremap = true, nowait = true, silent = true }
  api.nvim_buf_set_keymap(0, 'n', '<M-L>', '<cmd> lua require"dkg/supercollider".clear()<cr>', options)
  api.nvim_buf_set_keymap(0, 'n', '<Enter>', '<cmd> lua require"dkg/supercollider".toggle()<cr>', options)
end

sclang.on_start = function()
  M.bufnr = api.nvim_create_buf(true, true)
  api.nvim_buf_set_option(M.bufnr, 'filetype', 'scnvim')
  api.nvim_buf_set_name(M.bufnr, '[sclang]')
  M.winnr = M.open()
end

sclang.on_read = function(data)
  if M.is_valid() then
    api.nvim_buf_set_lines(M.bufnr, -1, -1, true, {data})
    if M.is_open() then
      local num_lines = api.nvim_buf_line_count(M.bufnr)
      api.nvim_win_set_cursor(M.winnr, {num_lines, 0})
    end
  end
end

sclang.on_exit = function(code, signal)
  if not M.is_open() then
    api.nvim_win_close(M.winnr, true)
    api.nvim_buf_delete(M.bufnr, { force = true })
  end
end

return M
