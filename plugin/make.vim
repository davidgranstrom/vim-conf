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

nnoremap <silent> <F5> :lua require('make').make()<cr>
