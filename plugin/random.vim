" File: plugin/random.vim
" Author: David Granström
" Description: Mappings for random utilities.

if exists('g:random_loaded')
  finish
endif
let g:random_loaded = 1

function s:array_opts() abort
  let size = str2nr(input('size: '))
  let min = str2nr(input('min: ', 0))
  let max = str2nr(input('max: ', 1))
  return [size, min, max]
endfunction

function s:insert_float_array() abort
  let opts = s:array_opts()
  let array = luaeval('require"random".float_array(unpack(_A))', opts)
  call nvim_input(array)
endfunction

function s:insert_int_array() abort
  let opts = s:array_opts()
  let array = luaeval('require"random".int_array(unpack(_A))', opts)
  call nvim_input(array)
endfunction

" mappings

inoremap <silent> <A-f> <c-o>:call nvim_input(luaeval('require"random".float()'))<cr>
inoremap <silent> <A-i> <c-o>:call nvim_input(luaeval('require"random".int()'))<cr>
inoremap <silent> <A-a>f <c-o>:call <SID>insert_float_array()<cr>
inoremap <silent> <A-a>i <c-o>:call <SID>insert_int_array()<cr>
