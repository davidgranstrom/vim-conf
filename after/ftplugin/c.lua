local setlocal = vim.opt_local
local buf_map = require'dkg.utils'.buf_map

setlocal.cinoptions = 'l1'
setlocal.commentstring = [[// %s]]
buf_map('n', '<leader>a', '<cmd>ClangdSwitchSourceHeader<cr>', {silent = true})

-- Delete doxygen comments and insert function body.
function remove_doxygen()
  vim.cmd [[ g/^\s*\*\|\/\*/d ]]
  vim.cmd [[ g/;/execute "normal! $xo{\<cr>}" ]]
end
