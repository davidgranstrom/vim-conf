local set_keymap = vim.api.nvim_set_keymap

local function nnoremap(lhs, rhs, options)
  options = vim.tbl_extend('keep', {noremap = true}, options)
  api.nvim_set_keymap('n', lhs, rhs, options)
end

local function inoremap(lhs, rhs, options)
  options = vim.tbl_extend('keep', {noremap = true}, options)
  api.nvim_set_keymap('i', lhs, rhs, options)
end

-- edit init.lua
nnoremap('<leader>ev', '<cmd>tabedit $MYVIMRC<cr>')
-- nnoremap('<leader>c', ':cd %:p:h \| pwd<cr>')
