" ------------------------------------------------------------------------------
" -- settings ------------------------------------------------------------------

setlocal cinoptions=l1
setlocal commentstring=\/\/\ %s
setlocal omnifunc=v:lua.vim.lsp.omnifunc

nnoremap <buffer><silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <buffer><silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <buffer><silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <buffer><silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <buffer><silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <buffer><silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <buffer><silent> gr    <cmd>lua vim.lsp.buf.references()<CR>

nnoremap <buffer><silent> <leader>a :ClangdSwitchSourceHeader<cr>

" diagnostics
nnoremap <leader>n <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>
nnoremap <leader>o <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
