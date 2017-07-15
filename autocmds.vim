if exists('g:loaded_autocmds')
  finish
endif
let g:loaded_autocmds = 1

let s:dkg_scvimrc = '~/.vim/bundle/vim-dkg/supercollider/scvim_init.vim'
if filereadable(expand(s:dkg_scvimrc))
  " supercollider
  source ~/.vim/bundle/vim-dkg/supercollider/scvim_init.vim
endif

if has('autocmd')
  if has('nvim')
    " make autoread behave as expected (neovim only)
    au! FocusGained * if &autoread | silent checktime | endif
  endif

  " c
  augroup dkg_c
    autocmd!
    autocmd FileType c set commentstring=\/\/\ %s
  augroup END

  " haskell
  augroup dkg_haskell
    autocmd!
    let g:haskellmode_completion_ghc = 0
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
  augroup END

  " markdown
  augroup dkg_markdown
    autocmd!
    autocmd BufEnter,BufWinEnter,BufNewFile,BufRead *.md,*.markdown set filetype=markdown
    autocmd BufEnter,BufWinEnter,BufNewFile,BufRead *.md,*.markdown set commentstring=<!--%s-->
  augroup END

  " javascript
  augroup dkg_javascript
    autocmd!
    autocmd FileType javascript.jsx setlocal filetype=javascript
    autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
    autocmd FileType javascript,typescript, setlocal ts=2 sts=2 sw=2
    autocmd FileType css,less,scss,sass setlocal ts=2 sts=2 sw=2
    autocmd FileType javascript set nowritebackup
    autocmd FileType javascript nnoremap <leader>f :ALEFix<cr>
  augroup END

  " python
  augroup dkg_python
    autocmd!
    autocmd FileType python setlocal ts=4 sts=4 sw=4
  augroup END

  " fugitive
  augroup dkg_fugitive
    autocmd!
    " enable spell checking in commit messages
    autocmd BufEnter,BufWinEnter */.git/index set spell | set spelllang=en
  augroup END

  " php
  function! TogglePhpHtml()
    if &ft == "php"
      set ft=html
    else
      set ft=php
    endif
  endfunction

  augroup dkg_php
    autocmd!
    autocmd FileType php nnoremap <leader>s :call TogglePhpHtml()<cr>
    " autocmd FileType html nnoremap <leader>s :set ft=html
  augroup END
endif
