vim.cmd [[ augroup nvim_init ]]
vim.cmd [[ autocmd! ]]
vim.cmd [[
  " remember last cursor position
  autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif

  autocmd BufRead,BufNewFile *.h,*.c set filetype=c

  " c#
  autocmd FileType cs set tabstop=4 softtabstop=4 shiftwidth=4

  " markdown
  autocmd FileType markdown setlocal commentstring=<!--%s-->

  " break undo sequence into smaller chunks for prose
  autocmd FileType markdown inoremap <buffer> . .<c-g>u
  autocmd FileType markdown inoremap <buffer> ? ?<c-g>u
  autocmd FileType markdown inoremap <buffer> ! !<c-g>u
  autocmd FileType markdown inoremap <buffer> , ,<c-g>u

  " javascript
  autocmd FileType javascript.jsx setlocal filetype=javascript
  autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
  " hack to make development servers not rebuild twice
  autocmd FileType javascript setlocal nowritebackup

  " python
  autocmd FileType python setlocal ts=4 sts=4 sw=4

  " cmake
  autocmd FileType cmake setlocal commentstring=#%s

  " git
  autocmd FileType gitcommit setlocal spell | setlocal spelllang=en

  " highlight yanked text
  autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=80}

]]
vim.cmd [[ augroup END ]]
