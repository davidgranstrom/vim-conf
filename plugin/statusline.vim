" File: plugin/statusline.vim
" Author: David Granström
" Description: Status line functions

if exists('g:statusline_loaded') || !has('nvim-0.5')
  finish
endif
let g:statusline_loaded = 1

scriptencoding utf-8

function! s:active_status() abort
  lua require('dkg/statusline').active()
endfunction

function! s:inactive_status() abort
  lua require('dkg/statusline').inactive()
endfunction

function! Tabline() abort
  return luaeval('require("dkg/statusline").tabline()')
endfunction

augroup statusline
  autocmd!
  autocmd WinEnter,BufEnter * call <sid>active_status()
  autocmd WinLeave,BufLeave * call <sid>inactive_status()
augroup END

set tabline=%!Tabline()
