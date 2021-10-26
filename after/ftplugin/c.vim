" ------------------------------------------------------------------------------
" -- settings ------------------------------------------------------------------

setlocal cinoptions=l1
setlocal commentstring=\/\/\ %s
nnoremap <buffer><silent> <leader>a :ClangdSwitchSourceHeader<cr>

lua << EOF
-- Delete doxygen comments and insert function body.
function remove_doxygen()
  vim.cmd [[ g/^\s*\*\|\/\*/d ]]
  vim.cmd [[ g/;/execute "normal! $xo{\<cr>}" ]]
end
EOF
