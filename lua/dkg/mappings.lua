local map = require'dkg.utils'.map
local buf_map = require'dkg.utils'.buf_map

-- set map leader to <Space>
vim.cmd [[ let mapleader = ' ' ]]
vim.cmd [[ let maplocalleader = ' ' ]]

-- edit init.lua
map('n', '<leader>ev', '<cmd>tabedit $MYVIMRC<cr>')

-- change to current directory
map('n', '<leader>c', '<cmd>cd %:p:h | pwd<cr>')

-- exit insert mode
map('i', 'jk', '<Esc>')

-- save buffer
map({'n', 'i'}, '<A-s>', '<cmd>write<cr>')

-- unmap help
map({'n', 'i'}, '<F1>', '<Esc>')

-- horizontal scrolling
map('n', '<C-l>', '10zl')
map('n', '<C-h>', '10zh')

-- move to the right in insert mode
map('i', '<C-l>', '<Right>')

-- paste last yanked item
map({'n', 'x'}, 'gp', '"0p')

-- edit current buffer in a new tab
map('n', '<leader>z', '<cmd>tabedit!%<cr>')

-- resize windows with arrow-keys
local directions = {'up', 'right', 'down', 'left'}
local win_cmds = {'+', '>', '-', '<'}
for i = 1, #directions do
  local lhs = string.format('<%s>', directions[i])
  local rhs = string.format('<cmd>3wincmd %s<cr>', win_cmds[i])
  map('n', lhs, rhs, {silent = true})
end

-- never enter Ex mode
map('n', 'Q', '<Nop>')

-- easy renaming
map('n', '<leader>r', '*``cgn')

-- don't move cursor after visual selection yank
map('v', '<expr>y', [["my\"" . v:register . "y`y"]])

-- remap esc in terminal mode
map('t', '<Esc>', '<C-\\><C-n>')

-- split single line function calls
map('n', '<leader><cr>', '<cmd>lua split_single_call()<cr>', {silent = true})

-- navigate from terminal buffers
local t_directions = {'h', 'j', 'k', 'l'}
for _, dir in ipairs(t_directions) do
  local lhs = string.format('<A-%s>', dir)
  local rhs = string.format('<C-\\><C-n><C-w>%s', dir)
  map('t', lhs, rhs, {silent = true})
end

--- LSP

local function lsp_mappings(bufnr)
  local opts = {silent = true}
  buf_map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_map(bufnr, 'n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_map(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>o', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_map(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_map(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_map(bufnr, 'n', '<leader>i', [[<cmd>lua require'telescope.builtin'.lsp_references()<CR>]], opts)
  buf_map(bufnr, 'n', '<leader>y', [[<cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>]], opts)
end

return {
  lsp_mappings = lsp_mappings
}
