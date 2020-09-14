" File: plugin/random.vim
" Author: David Granström
" Description: Mappings for random utilities.

if exists('g:random_loaded')
  finish
endif
let g:random_loaded = 1

function s:insert_float() abort
  call nvim_feedkeys(luaeval('require"dkg/random".float()'), 'i', v:true)
endfunction

function s:insert_int() abort
  call nvim_feedkeys(luaeval('require"dkg/random".int()'), 'i', v:true)
endfunction

function s:array_opts() abort
  let size = str2nr(input('size: '))
  let min = str2nr(input('min: ', 0))
  let max = str2nr(input('max: ', 1))
  return [size, min, max]
endfunction

function s:insert_float_array() abort
  let opts = s:array_opts()
  let array = luaeval('require"dkg/random".float_array(unpack(_A))', opts)
  call nvim_feedkeys(array, 'i', v:true)
endfunction

function s:insert_int_array() abort
  let opts = s:array_opts()
  let array = luaeval('require"dkg/random".int_array(unpack(_A))', opts)
  call nvim_feedkeys(array, 'i', v:true)
endfunction

function s:set_int_range(...) abort
  call luaeval('require"dkg/random".set_int_range(unpack(_A))', a:000)
endfunction

function s:set_float_range(...) abort
  call luaeval('require"dkg/random".set_float_range(unpack(_A))', a:000)
endfunction

" mappings

inoremap <silent> <A-f> <c-\><c-o>:call <SID>insert_float()<cr>
inoremap <silent> <A-i> <c-\><c-o>:call <SID>insert_int()<cr>
inoremap <silent> <A-a>f <c-o>:call <SID>insert_float_array()<cr>
inoremap <silent> <A-a>i <c-o>:call <SID>insert_int_array()<cr>

" commands

command! -nargs=* RndSetIntRange call <SID>set_int_range(<f-args>)
command! -nargs=* RndSetFloatRange call <SID>set_float_range(<f-args>)
