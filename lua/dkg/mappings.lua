local map = require'dkg.utils'.map

vim.cmd [[ let mapleader = ' ' ]]
vim.cmd [[ let maplocalleader = ' ' ]]

-- edit init.lua
map('n', '<leader>ev', '<cmd>tabedit $MYVIMRC<cr>')
-- change to current directory
map('n', '<leader>c', '<cmd>cd %:p:h | pwd<cr>')
-- exit insert mode
map('i', 'jk', '<Esc>')
-- Y should behave like C and D
map('n', 'Y', 'y$')
-- save buffer
map({'n', 'i'}, '<A-s>', '<cmd>write<cr>')
-- unmap help
map({'n', 'i'}, '<F1>', '<Esc>')
-- horizontal scrolling
map('n', '<C-l>', '10zl')
map('n', '<C-h>', '10zh')
-- move a step to the right in insert mode 
map('i', '<C-l>', '<C-o>l')
-- paste last yanked item
map({'n', 'x'}, 'gp', '"0p')
-- edit current buffer in a new tab
map('n', '<leader>z', '<cmd>tabedit!%<cr>')
-- resize windows with arrow-keys
local directions = {'up', 'right', 'down', 'left'}
local win_cmds = {'+', '>', '-', '<'}
for i = 1, #directions do
  local lhs = string.format('<%s>', directions[i])
  local rhs = string.format('<cmd>3wincmd %s', win_cmds[i])
  map('n', lhs, rhs, {silent = true})
end
-- never enter Ex mode
map('n', 'Q', '<Nop>')
-- easy renaming
map('n', '<leader>r', '*``cgn')
-- don't move cursor after visual selection yank
map('v', '<expr>y', '"my\"" . v:register . "y`y"')
-- remap esc in terminal mode
map('t', '<Esc>', '<C-\\><C-n>')
-- navigate from terminal buffers
local t_directions = {'h', 'j', 'k', 'l'}
for _, dir in ipairs(t_directions) do
  local lhs = string.format('<A-%s>', dir)
  local rhs = string.format('<C-\\><C-n><C-w>%s', dir)
  map('t', lhs, rhs, {silent = true})
end
