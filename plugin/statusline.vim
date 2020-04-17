" File: plugin/statusline.vim
" Author: David Granström
" Description: Status line functions

scriptencoding utf-8

function! ActiveStatus() abort
  return luaeval('require("statusline").active()')
endfunction

function! InactiveStatus() abort
  return luaeval('require("statusline").inactive()')
endfunction

function! Tabline() abort
  return luaeval('require("statusline").my_tabline()')
endfunction

augroup statusline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveStatus()
  autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveStatus()
augroup END

set tabline=%!Tabline()
