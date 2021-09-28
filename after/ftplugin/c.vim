" ------------------------------------------------------------------------------
" -- settings ------------------------------------------------------------------

setlocal cinoptions=l1
setlocal commentstring=\/\/\ %s

nnoremap <buffer><silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <buffer><silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <buffer><silent> <leader>k <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <buffer><silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <buffer><silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <buffer><silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <buffer><silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
" nnoremap <buffer><silent> <leader>sy <cmd>lua vim.lsp.buf.document_symbol()<cr>
" nnoremap <buffer><silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <buffer><silent> <leader>r <cmd>lua vim.lsp.buf.rename()<cr>


nnoremap <buffer><silent> <leader>a :ClangdSwitchSourceHeader<cr>

" diagnostics
nnoremap ]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap [d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <leader>o <cmd>lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})<CR>

nnoremap <buffer><silent> <leader>i <cmd>Telescope lsp_references<cr>
nnoremap <buffer><silent> <leader>y <cmd>Telescope lsp_document_symbols<cr>

command! -buffer -nargs=? ReplaceAll lua vim.lsp.buf.rename(<args>)<CR>

lua << EOF

-- Delete doxygen comments.
function remove_doxygen()
  vim.cmd [[ g/^\s*\*\|\/\*/d ]]
  vim.cmd [[ g/;/execute "normal! $xo{\<cr>}" ]]
end

EOF
