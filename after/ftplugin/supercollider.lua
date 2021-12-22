local setlocal = vim.opt_local
local buf_map = require'dkg.utils'.buf_map

-- Indentation
setlocal.tabstop = 4
setlocal.shiftwidth = 4

buf_map(0, 'n', '<leader>d', '<cmd>Telescope scdoc<cr>', {silent = true})
