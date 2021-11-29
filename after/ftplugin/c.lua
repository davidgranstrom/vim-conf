local setlocal = vim.opt_local
local map = require'dkg.utils'.map

setlocal.cinoptions = 'l1'
setlocal.commentstring = [[// %s]]
map('n', '<leader>a', '<cmd>ClangdSwitchSourceHeader<cr>', {silent = true})

-- Delete doxygen comments and insert function body.
function remove_doxygen()
  vim.cmd [[ g/^\s*\*\|\/\*/d ]]
  vim.cmd [[ g/;/execute "normal! $xo{\<cr>}" ]]
end
