" File: plugin/make.vim
" Author: David Granström
" Description: Async make with quickfix integration

if exists('g:make_loaded')
  finish
endif
let g:make_loaded = 1

function! MakeQuickFix(list) abort
  if !empty(a:list)
    cexpr a:list
    copen
  else
    cclose
  endif
endfunction

function! MakeBuildProgress() abort
  let progress = get(w:, 'make_progress', '')
  if progress !=# ''
    return '['.progress.']'
  endif
  return ''
endfunction

function! MakeRunCurrentTest() abort
  let testname = expand('%:p:t:r')
  let testdir = expand('%:h')
  vsplit +term
  startinsert
  let cmd = 'cd '.testdir.'<cr>'
  let cmd .= 'make ' . testname
  let cmd .= ' && ./'.testname
  call nvim_input(cmd)
endfunction

nnoremap <silent> <F3> :lua require('make').make()<cr>
nnoremap <silent> <F4> :call MakeRunCurrentTest()<cr>
