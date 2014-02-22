"
" gvimrc
"
" ==============================================================================
"
" unmap and remap keys from GUI menus
if has("gui_macvim")
    " macmenu &File.New\ Tab key=<nop>
    macmenu &Tools.Make key=<nop>
    "other remaps
    macmenu &File.New\ Window key=<nop>
    macmenu &File.Print key=<nop>
    macmenu &Edit.Cut key=<nop>
    macmenu &Tools.List\ Errors key=<nop>
    " don't use any alerts
    " set vb t_vb=
    set visualbell
endif

" vim:foldmethod=marker colorcolumn=80 textwidth=80
