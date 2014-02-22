"
" vimrc
"
" ==============================================================================
" GLOBAL
" ==============================================================================
" {{{

" setup pathogen
if !isdirectory(expand("~/.vim/bundle"))
    call mkdir(expand("~/.vim/bundle"), "p")
endif
if !isdirectory(expand("~/.vim/autoload"))
    call mkdir(expand("~/.vim/autoload"), "p")
endif

if !filereadable(expand("~/.vim/autoload/pathogen.vim")) 
    !curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
endif

call pathogen#infect()
call pathogen#helptags()

set nocompatible                    " no need to be compatible with vi

filetype plugin indent on           " detect plugin filetypes
syntax enable                       " syntax highlighting

set directory^=$HOME/.vim/.swap//   " put all swap files in one place
let mapleader=","                   " set mapleader
set mouse=a                         " enable mouse

" editing
set backspace=2                     " allow backspacing over indent, eol, and the start of an insert
set virtualedit=all                 " be able to access all areas of the buffer
set hidden                          " be able to hide modified buffers
set complete-=i                     " where to look for auto-completion
set clipboard=unnamed               " yank to system-wide clipboard
set formatoptions+=r                " auto insert comments from insert mode

" appearance
set fillchars=                      " remove the fillchars from folds and splits
set listchars=tab:>-,trail:–,nbsp:• " custom list chars
set nostartofline                   " keep the cursor at the current column when moving
set scrolloff=8                     " keep a distance of from the cursor when scrolling
set nowrap                          " don't wrap words

" searching
set ignorecase                      " ignore case in search patterns
set incsearch                       " incrementally match the search
set smartcase                       " overrides 'ignorecase' if search pattern contains an upper char
set showmatch                       " highlight search matches while typing

" misc
set ttyfast                         " assume fast terminal connection
set wildmenu                        " enhanced command line completion
set wildignorecase                  " be smart case-sensitive
set diffopt+=vertical               " use vertical diffs by default
set laststatus=2                    " always display a status line
set autochdir                       " change to cwd of current file
set visualbell                      " turn off error beep/flash
set regexpengine=2                  " use the improved regexpengine
set timeout timeoutlen=600          " shorter timeout lenght for keystrokes

" indenting/formating
set autoindent                      " indent even if we have no filetype rules
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab                       " use whitespace instead of tabs
set shiftround                      " round indent to multiples of 'shiftwidth'

" colorscheme
if has("gui_running")
    " set colorscheme and fonts
    " colorscheme kellys
    colorscheme jellybeans
    " change to alternate theme
    if has("gui_macvim")
        set transparency=3
    endif
    " set guifont=Monospace,Menlo:h12
    set guifont=Monospace,Meslo\ LG\ S\ for\ Powerline:h12
    " style guicursor
    set guicursor=n-c-v:block-Cursor-blinkOn0
    " get rid of all scrollbars and the toolbar
    set guioptions-=T
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set guioptions-=b
    "use console dialogs for simple choices
    set guioptions+=c
else
    " use 256 colors in terminal
    set t_Co=256
    colorscheme jellybeans
endif

" }}}
" ==============================================================================
" FUNCTIONS
" ==============================================================================
" {{{

com! -nargs=0 SoftWrapToggle call SoftWrapToggle()
let g:dkg_toggleSoftWrap = 0
function! SoftWrapToggle()
    if g:dkg_toggleSoftWrap == 1
        set nowrap | set nolinebreak
        let g:dkg_toggleSoftWrap = 0
    else
        set wrap | set linebreak
        let g:dkg_toggleSoftWrap = 1
    endif
endfunction

" toggle the quickfix window
let g:dkg_quickFixIsOpen = 0
function! ToggleQuickFix()
    if g:dkg_quickFixIsOpen == 0
        copen
        let g:dkg_quickFixIsOpen = 1
    else
        cclose
        let g:dkg_quickFixIsOpen = 0
    endif
endfunction
nnoremap <silent><leader>qf :call ToggleQuickFix()<cr>

" toggle fold column
com! -nargs=0 FoldColumnToggle call ToggleFoldColumn()
let g:dkg_setfoldcolumn = 0
function! ToggleFoldColumn()
    if g:dkg_setfoldcolumn == 0
        let g:dkg_setfoldcolumn= 1
        set foldcolumn=4
    else
        let g:dkg_setfoldcolumn= 0
        set foldcolumn=0
    endif
endfunction

" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <Leader><F12> :call <SID>SynStack()<CR>

" delete trailing whitespace in the whole buffer
function! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunction

"let g:dkg_xcodeComments = 0
"function! XcodeComments() range
"    if g:dkg_xcodeComments == 1
"        exec a:firstline . "," . a:lastline . 's/^\/\/\ze//g'
"        let g:dkg_xcodeComments = 0
"    else
"        exec a:firstline . "," . a:lastline . 's/^\ze/\/\//g'
"        let g:dkg_xcodeComments = 1
"    endif
"endfunction
"" com! -nargs=0 XcodeComments call XcodeComments()
"com! -range XcodeComments <line1>,<line2> call XcodeComments()
"au! BufEnter,BufWinEnter,BufNewFile,BufRead *.m,*.h nnoremap gc :XcodeComments<cr>
"au! BufEnter,BufWinEnter,BufNewFile,BufRead *.m,*.h xnoremap gc :XcodeComments<cr>
" nnoremap <leader>x :call XcodeComments()<cr>
" xnoremap <leader>x :call XcodeComments()<cr>

" Load matchit.vim, but only if the user hasn't installed a newer version.
" if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    source $VIMRUNTIME/macros/matchit.vim
" endif

" }}}
" ==============================================================================
" KEY MAPPINGS
" ==============================================================================
" {{{

" edit vimrc
nnoremap <leader>ev :tabe $MYVIMRC<CR>

" save and source current file
nnoremap <silent> <leader>so :w<CR>:so%<CR>
    \:echo "Saved and sourced current buffer.."<CR>

" change to current dir
nnoremap <leader>cd :cd %:p:h\|pwd<cr>

" toggle search highlighting
noremap <F8> :set hlsearch? hlsearch!<CR>

" toggle cursor line highlighting
noremap <Leader>cl :set cursorline! cursorline?<CR>

" toggle cursor column highlighting
noremap <Leader>cc :set cursorcolumn! cursorcolumn?<CR>

" toggle line numbers
noremap <Leader>nu :set rnu! rnu?<CR>

" unmap help, and replace with <Esc>
map <F1> <Esc>
map! <F1> <Esc>

" exit insert mode
imap jk <Esc>

" make horizontal scrolling easier
nnoremap <C-l> 10zl
nnoremap <C-h> 10zh

" spelling suggestions
nnoremap <c-s> 1z=
inoremap <c-s> <c-g>u<c-o>1z=

" alternative scrolling
nnoremap <C-j> 3<C-e>3j
nnoremap <C-k> 3<C-y>3k

" easier resizing
nnoremap <C-w>< <C-w>15<
nnoremap <C-w>> <C-w>15>
nnoremap <C-w>+ <C-w>15+
nnoremap <C-w>- <C-w>15-

" make Y behave like D
nnoremap Y y$

" create an empty buffer for SuperCollider code
nnoremap <leader>sn :SCNewScratchBuf<CR>

" use <esc> to cancel completion
inoremap <expr> <Esc> pumvisible() ? "\<C-y>" : "\<Esc>"
inoremap <expr> <C-c> pumvisible() ? "\<C-e>" : "\<C-c>"

" edit current buffer in a new tab
nnoremap <silent><leader>z :tabedit!%<cr>
nnoremap <silent><leader>tl :tabmove +1<cr>
nnoremap <silent><leader>th :tabmove -1<cr>
if has("gui_macvim")
    nnoremap <D-1> 1gt
    nnoremap <D-2> 2gt
    nnoremap <D-3> 3gt
    nnoremap <D-4> 4gt
    nnoremap <D-5> 5gt
    nnoremap <D-Left>  :tabmove -1<CR>
    nnoremap <D-Right> :tabmove +1<CR>
endif

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" }}}
" ==============================================================================
" LANGUAGE SETTINGS
" ==============================================================================
" {{{

" supercollider
au FileType supercollider set tags^=$HOME/.sctags
" source supercollider mappings
so ~/.vim/bundle/dkg/supercollider/scvim_init.vim
if filereadable(expand("~/.scvimrc"))
    so ~/.scvimrc
endif

" markdown
au! BufEnter,BufWinEnter,BufNewFile,BufRead *.md,*.markdown set filetype=markdown

" work
au! BufEnter,BufWinEnter,BufNewFile,BufRead /Volumes/source/* set directory=/Volumes/source/.swp//

" }}}
" ==============================================================================
" PLUGIN CONFIGURATION
" ==============================================================================
" {{{

" -- NerdTREE  ---------------------------------------------------------------

" toggle
nnoremap <silent> <F2> :NERDTreeToggle ~/<CR>
nnoremap <silent> <F3> :NERDTreeFind<CR>

" ----------------------------------------------------------------------------
" -- Unite  ------------------------------------------------------------------

let g:unite_source_history_yank_enable = 1
" call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file,file/new,buffer,file_rec',
            \ 'matchers', 'matcher_fuzzy')

nnoremap <leader>tt :<C-u>Unite -start-insert file_rec/async<cr>
nnoremap <leader>r  :<C-u>Unite -start-insert file_rec/async:!<cr>
nnoremap <leader>b  :<C-u>Unite -no-split buffer<cr>
nnoremap <leader>.  :<C-u>Unite file<cr>

nnoremap <leader>m :<C-u>Unite -no-split file_mru<cr>
nnoremap <leader>y :<C-u>Unite history/yank<cr>

nnoremap <leader>/ :<C-u>Unite grep:%<cr>
nnoremap <leader>gb :<C-u>Unite grep:$buffers<cr>
nnoremap <leader>gg :<C-u>Unite grep:<cr>

nnoremap <leader>o :<C-u>Unite outline<cr>

autocmd FileType unite call s:unite_my_settings()
" overwrite default settings
function! s:unite_my_settings()
    nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
    nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
    inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
endfunction

if executable('ag')
    " Use ag in unite grep source.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden'
    let g:unite_source_grep_recursive_opt = ''
elseif executable('grep')
    " otherwise use grep
    let g:unite_source_grep_command = 'grep'
    let g:unite_source_grep_default_opts = '--colour=never'
    let g:unite_source_grep_recursive_opt = ''
endif

" ----------------------------------------------------------------------------
" -- SuperTab  ---------------------------------------------------------------

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabCrMapping = 0

" ----------------------------------------------------------------------------
" -- Gundo  ------------------------------------------------------------------

nnoremap <F4> :GundoToggle<CR>

" ----------------------------------------------------------------------------
" -- EasyAlign  --------------------------------------------------------------

vnoremap <Space> :EasyAlign<cr>
" vnoremap <Space> <Plug>(EasyAlign)
" nnoremap <Leader>a <Plug>(EasyAlign)

" ----------------------------------------------------------------------------
" -- UltiSnips  --------------------------------------------------------------

let g:UltiSnipsListSnippets = "<c-\\>"
let g:UltiSnips_Author = "David Granstrom"
let g:UltiSnipsExpandTrigger       = "<Tab>"
let g:UltiSnipsJumpForwardTrigger  = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-h>"
let g:UltiSnipsUsePythonVersion = 2

" ----------------------------------------------------------------------------
" -- Commentary  -------------------------------------------------------------

xmap gc  <Plug>Commentary
nmap gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine

" ----------------------------------------------------------------------------
" -- Surround  ---------------------------------------------------------------

xmap s <plug>VSurround

" ----------------------------------------------------------------------------
" -- Fugitive  ---------------------------------------------------------------

nnoremap <Leader>fs :Gstatus<CR><C-w>K
autocmd BufNewFile,BufRead fugitive://* set bufhidden=delete

" ----------------------------------------------------------------------------
" -- delimitMate  ------------------------------------------------------------

imap <C-l> <Plug>delimitMateS-Tab
imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"
let delimitMate_expand_cr    = 1
let delimitMate_expand_space = 1

" ----------------------------------------------------------------------------
" -- clang_complete  ---------------------------------------------------------

" let g:clang_snippets_engine  = 'ultisnips'
" let g:clang_snippets         = 1
" let g:clang_conceal_snippets = 1
" let g:clang_close_preview    = 1
" let g:clang_use_library      = 1
" let g:clang_library_path='/usr/local/lib/libclang.dylib'
" let g:clang_exec = '/usr/local/bin/clang'

" ----------------------------------------------------------------------------
" -- airline  ----------------------------------------------------------------

let g:airline_theme             = 'dark'
" let g:airline_theme             = 'jellybeans'
let g:airline_enable_syntastic  = 0
let g:airline_detect_whitespace = 0
if has("gui_running")
    let g:airline_powerline_fonts = 1
endif
" let g:airline_section_z = g:airline_linecolumn_prefix . '%3c:%3l%3p%%'
" let g:airline_fugitive_prefix = '⎇ '
" call s:check_defined('g:airline_section_z', '%3p%% '.g:airline_linecolumn_prefix.'%3l:%3c')

" ----------------------------------------------------------------------------
" -- YCM  --------------------------------------------------------------------

" let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" ----------------------------------------------------------------------------
" -- FSwitch  ----------------------------------------------------------------

nnoremap <silent> <Leader>s :FSSplitAbove<cr>
nnoremap <silent> <Leader>a :FSHere<cr>

" ========================================================================={{{

" vim:foldmethod=marker colorcolumn=80 textwidth=80
