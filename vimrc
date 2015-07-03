"
" vimrc
"
" ==============================================================================
" GLOBAL
" ==============================================================================
" {{{

set nocompatible           " no need to be compatible with vi
filetype plugin indent on  " detect plugin filetypes
syntax enable              " syntax highlighting

" vim-plug
call plug#begin('~/.vim/bundle')

" appearance
Plug 'bling/vim-airline'
Plug 'junegunn/goyo.vim', { 'on' : 'Goyo' }

" editing
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'Raimondi/delimitMate'
Plug 'ervandew/supertab'
" Plug 'ajh17/VimCompletesMe'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'honza/vim-snippets'

" navigation
Plug 'derekwyatt/vim-fswitch'
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'scrooloose/nerdtree'
Plug 'kopischke/vim-fetch'

" util
Plug 'tpope/vim-fugitive'
Plug 'fmoralesc/vim-pad'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'junegunn/vim-peekaboo'
Plug 'tmux-plugins/vim-tmux-focus-events'

" vim
Plug 'tpope/vim-scriptease'
Plug 'vim-scripts/matchit.zip'

" language
Plug 'b4winckler/vim-objc'
Plug 'ryotakato/unite-outline-objc'
Plug 'sophacles/vim-processing', { 'for': 'processing' }
" Plug 'davidgranstrom/scvim', { 'branch' : 'dkg' }
" Plug 'davidgranstrom/scvim'
Plug 'sbl/scvim'
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
" Plug 'clausreinke/typescript-tools.vim', { 'for': 'typescript' }
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
Plug 'moll/vim-node'
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
Plug 'wookiehangover/jshint.vim'
Plug 'scrooloose/syntastic'

" color schemes
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'tomasr/molokai'

" misc
Plug 'tpope/vim-repeat'
Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_mac.mak' }
Plug 'tpope/vim-unimpaired'
Plug 'davidgranstrom/vim-dkg'
Plug 'fmoralesc/vim-tutor-mode'

call plug#end()

set directory^=$HOME/.vim/.swap//   " put all swap files in one place
let mapleader="\<space>"            " set mapleader
set mouse=a                         " enable mouse

" editing
set backspace=2                     " allow backspacing over indent, eol, and the start of an insert
set virtualedit=all                 " be able to access all areas of the buffer
set hidden                          " be able to hide modified buffers
set complete-=i                     " where to look for auto-completion
set clipboard=unnamed               " yank to system-wide clipboard
set autoread                        " reload buffers changed from the outside
set formatoptions+=rj               " auto insert comments from insert mode,
                                    " remove comment leader when joining lines

" appearance
set fillchars=                      " remove the fillchars from folds and splits
set listchars=tab:>-,trail:–,nbsp:• " custom list chars
set nostartofline                   " keep the cursor at the current column when moving
set scrolloff=8                     " keep a distance of from the cursor when scrolling
set nowrap                          " don't wrap words
set linebreak                       " break at word boundries for wrapped text

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
" set autochdir                       " change to cwd of current file
set visualbell                      " turn off error beep/flash
set regexpengine=2                  " use the improved regexpengine
set timeoutlen=1000                 " shorter timeout lenght for keystrokes
set ttimeoutlen=50                  " make esc work faster
set lazyredraw                      " don't redraw screen for macros

" indenting/formating
set autoindent                      " indent even if we have no filetype rules
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab                       " use whitespace instead of tabs
set shiftround                      " round indent to multiples of 'shiftwidth'

" colorscheme/appearance
if has("gui_running")
    set background=dark
    " colorscheme gruvbox
    " colorscheme seoul256
    colorscheme molokai

    if has("gui_macvim")
        set transparency=3
    endif

    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h14,Monospace
    " style guicursor
    set guicursor=n-c-v:block-Cursor-blinkOn0

    " get rid of all scrollbars and the toolbar
    set guioptions-=T
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set guioptions-=b
    set guioptions-=m
    set guioptions-=e
    " use console dialogs for simple choices
    set guioptions+=c
else
    " use 256 colors in terminal
    set background=dark
    " colorscheme gruvbox
    " colorscheme seoul256
    colorscheme molokai

    " let &t_SI .= "\ePtmux;\e\e[5 q\e\\"
    " let &t_EI .= "\ePtmux;\e\e[1 q\e\\"

    if &term =~ '256color'
        " disable Background Color Erase (BCE) so that color schemes
        " render properly when inside 256-color tmux and GNU screen.
        " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
        set t_ut=
    endif
endif

" use par to format text
if executable("par")
    set formatprg=par\ -w80qr
endif

" source the manpage plugin
source $VIMRUNTIME/ftplugin/man.vim

" }}}
" ==============================================================================
" FUNCTIONS
" ==============================================================================
" {{{

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

" " Show syntax highlighting groups for word under cursor
" function! <SID>SynStack()
"   if !exists("*synstack")
"     return
"   endif
"   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunc
" nmap <Leader><F12> :call <SID>SynStack()<CR>

" delete trailing whitespace in the whole buffer
function! DeleteTrailingWS()
  normal! m`
  %s/\s\+$//ge
  normal! ``
endfunction

com! DeleteTrailingWS :call DeleteTrailingWS()
nnoremap _$ :DeleteTrailingWS<cr>
nnoremap __ :s/\s\+$//ge<cr>

" augroup checktime
"     au!
"     if !has("gui_running")
"         "silent! necessary otherwise throws errors when using command
"         "line window.
"         autocmd BufEnter * silent! checktime
"         autocmd CursorHold * silent! checktime
"         autocmd CursorHoldI * silent! checktime
"         "these two _may_ slow things down. Remove if they do.
"         " autocmd CursorMoved * silent! checktime
"         " autocmd CursorMovedI * silent! checktime
"     endif
" augroup END

" format json
com! FormatJSON %!python -m json.tool

" justify selected text
com! -nargs=0 -range Justify '<,'>!par \-w80qrj

" Allow saving of files as sudo when I forgot to start vim using sudo.
com! SudoWrite w !sudo tee > /dev/null %


" }}}
" ==============================================================================
" KEY MAPPINGS
" ==============================================================================
" {{{

" edit vimrc
nnoremap <leader>ev :tabe $MYVIMRC<CR>

augroup vimrc_reload
    autocmd!
    " save and source current file
    autocmd FileType vim nnoremap <buffer> <leader>so :w<cr>:so%<cr>:echo "Saved and sourced current buffer.."<cr>
augroup END

" change to current dir
nnoremap <leader>c :cd %:p:h\|pwd<cr>

" unmap help, and replace with <Esc>
map! <F1> <Esc>

" exit insert mode
imap jk <Esc>

" easier navigation in wrapped text
nnoremap j gj
nnoremap k gk

" navigate paragraphs
nnoremap <C-j> }
nnoremap <C-k> {

" make horizontal scrolling easier
nnoremap <C-l> 10zl
nnoremap <C-h> 10zh

" make Y behave like D
nnoremap Y y$

" create an empty buffer for SuperCollider code
nnoremap <leader>sn :SCNewScratchBuf<CR>

" use <esc> to cancel completion
inoremap <expr> <Esc> pumvisible() ? "\<C-y>" : "\<Esc>"
inoremap <expr> <C-c> pumvisible() ? "\<C-e>" : "\<C-c>"

" edit current buffer in a new tab
nnoremap <silent><leader>z :tabedit!%<cr>
" move between tabs
nnoremap <silent><C-n> :tabn<cr>
nnoremap <silent><C-p> :tabp<cr>
nnoremap <silent> ]t :tabn<cr>
nnoremap <silent> [t :tabp<cr>

" switch tabs web browser style
if has("gui_macvim")
    nnoremap <D-1> 1gt
    nnoremap <D-2> 2gt
    nnoremap <D-3> 3gt
    nnoremap <D-4> 4gt
    nnoremap <D-5> 5gt
    nnoremap <D-6> 6gt
    nnoremap <D-7> 7gt
    nnoremap <D-8> 8gt
    nnoremap <D-9> 9gt
endif

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" resize windows with arrow-keys
nnoremap <silent><left>  :3wincmd <<cr>
nnoremap <silent><right> :3wincmd ><cr>
nnoremap <silent><up>    :3wincmd +<cr>
nnoremap <silent><down>  :3wincmd -<cr>

" Move visual block
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" }}}
" ==============================================================================
" LANGUAGE SETTINGS
" ==============================================================================
" {{{

" supercollider
source ~/.vim/bundle/vim-dkg/supercollider/scvim_init.vim

if has("autocmd")
    " supercollider
    augroup supercollider_vimrc
        autocmd FileType supercollider let b:vcm_tab_complete = "tags"
    augroup END

    " c
    augroup c_comment
        autocmd!
        autocmd FileType c set commentstring=\/\/\ %s
    augroup END

    " haskell
    augroup haskell_omni
        autocmd!
        autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    augroup END

    " markdown
    augroup markdown
        autocmd!
        autocmd BufEnter,BufWinEnter,BufNewFile,BufRead *.md,*.markdown set filetype=markdown
        autocmd BufEnter,BufWinEnter,BufNewFile,BufRead *.md,*.markdown set commentstring=<!--%s-->
    augroup END

    " markdown
    augroup typescript
        autocmd!
        autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
		autocmd FileType typescript nmap <buffer> <Leader>k :<C-u>echo tsuquyomi#hint()<CR>
        autocmd FileType typescript setlocal ts=2 sts=2 sw=2
    augroup END

    " fugitive
    augroup fugitive_index
        autocmd!
        autocmd BufEnter,BufWinEnter */.git/index set spell | set spelllang=en
    augroup END

    function! TogglePhpHtml()
        if &ft == "php"
            set ft=html
        else
            set ft=php
        endif
    endfunction

    " php
    augroup php_vimrc
        autocmd!
        autocmd FileType php nnoremap <leader>s :call TogglePhpHtml()<cr>
        " autocmd FileType html nnoremap <leader>s :set ft=html
    augroup END

    " node
    augroup node_vimrc
        autocmd!
        " autocmd FileType js nnoremap <leader>s :call TogglePhpHtml()<cr>
        " autocmd FileType html nnoremap <leader>s :set ft=html
        autocmd FileType javascript setlocal ts=2 sts=2 sw=2
    augroup END


    " format html using pandoc
    let pandoc_pipeline  = "pandoc --from=html --to=markdown"
    let pandoc_pipeline .= " | pandoc --from=markdown --to=html"
    augroup html_format
        autocmd!
        autocmd FileType html let &formatprg=pandoc_pipeline
    augroup END
endif

" }}}
" ==============================================================================
" PLUGIN CONFIGURATION
" ==============================================================================
" {{{

" -- NerdTREE  ---------------------------------------------------------------

" toggle
nnoremap <silent> <F2> :NERDTreeToggle ~/<CR>
nnoremap <silent> <F3> :NERDTreeFind<CR>
let g:NERDTreeHijackNetrw=1

" ----------------------------------------------------------------------------
" -- Unite  ------------------------------------------------------------------

let g:unite_source_history_yank_enable = 1
" let g:unite_source_rec_max_cache_files = 0
let g:unite_force_overwrite_statusline = 0

call unite#filters#matcher_default#use([ 'matcher_fuzzy', 'matcher_hide_hidden_files', 'matcher_hide_current_file' ])
call unite#filters#sorter_default#use(['sorter_rank'])

call unite#custom#source(
    \ 'file_rec,file_rec/async,file_mru,file,buffer,grep',
    \ 'ignore_pattern', '\.git/'
    \ )

" position and style
call unite#custom#profile('default', 'context', {
\   'direction': 'botright',
\   'winheight': 10,
\   'cursor-line-time': 0.0,
\   'prompt': '» '
\ })

" override vim default [I (list lines containing <pattern>)
" nnoremap [I :execute 'Unite -no-resize -start-insert -buffer-name=search line:all' . expand("<cword>")<cr>
nnoremap <leader>ff :execute 'Unite grep:.::' . expand("<cword>")<cr>
nnoremap <leader>ft :execute 'Unite -buffer-name=files file_rec/async:! ' . expand("<cword>")<cr>
nnoremap <leader>t :<C-u>Unite -buffer-name=files -start-insert buffer file_rec/async:.<cr>
nnoremap <leader>b  :<C-u>Unite -no-split -no-resize buffer<cr>
nnoremap <leader>/  :<C-u>Unite -no-resize -start-insert line<cr>
nnoremap <leader>gg :<C-u>Unite grep:<cr>
nnoremap <leader>o  :<C-u>Unite -direction=topleft outline<cr>
nnoremap <leader>y  :<C-u>Unite history/yank<cr>

" overwrite default settings
function! s:unite_my_settings()
    imap <silent><buffer> jk <Plug>(unite_insert_leave)
    imap <silent><buffer> <C-j> <Plug>(unite_select_next_line)
    imap <silent><buffer> <C-k> <Plug>(unite_select_previous_line)
    nnoremap <silent><buffer><expr> <leader>n unite#do_action('split')
    nnoremap <silent><buffer><expr> <leader>v unite#do_action('vsplit')
    inoremap <silent><buffer><expr> <leader>n unite#do_action('split')
    inoremap <silent><buffer><expr> <leader>v unite#do_action('vsplit')
endfunction

augroup unite_settings
    autocmd!
    autocmd FileType unite call s:unite_my_settings()
augroup END

if executable('ag')
    " Use ag in unite grep source.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden --ignore="tags"'
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

vmap <leader><space> <Plug>(EasyAlign)
" For normal mode, with Vim movement (e.g. <Leader>aip)
nmap <leader><space> <Plug>(EasyAlign)

" ----------------------------------------------------------------------------
" -- UltiSnips  --------------------------------------------------------------

let g:UltiSnipsListSnippets        = "<c-\\>"
let g:UltiSnips_Author             = "David Granstrom"
let g:UltiSnipsExpandTrigger       = "<C-j>"
let g:UltiSnipsJumpForwardTrigger  = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsUsePythonVersion    = 2

" ----------------------------------------------------------------------------
" -- Surround  ---------------------------------------------------------------

xmap s <plug>VSurround

" ----------------------------------------------------------------------------
" -- Fugitive  ---------------------------------------------------------------

nnoremap <Leader>fs :Gstatus<CR><C-w>K
nnoremap <F5> :Gblame<cr>

" ----------------------------------------------------------------------------
" -- delimitMate  ------------------------------------------------------------

imap <C-l> <Plug>delimitMateS-Tab
imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"
let delimitMate_expand_cr    = 1
let delimitMate_expand_space = 1

" ----------------------------------------------------------------------------
" -- airline  ----------------------------------------------------------------

" let g:airline_enable_syntastic  = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 10

" ----------------------------------------------------------------------------
" -- FSwitch  ----------------------------------------------------------------

nnoremap <silent> <Leader>s :FSSplitAbove<cr>
nnoremap <silent> <Leader>a :FSHere<cr>

" ----------------------------------------------------------------------------
" -- Goyo  -------------------------------------------------------------------

let g:goyo_width = 80
let g:goyo_margin_top = 10
let g:goyo_margin_bottom = 10

" ----------------------------------------------------------------------------
" -- vim-pad -----------------------------------------------------------------

let g:pad#dir = "~/Documents/notes"
let g:pad#local_dir = "vim-pad-notes"
let g:pad#use_default_mappings = 0

nmap <silent><leader>pn <Plug>(pad-new)
nmap <silent><leader>pl <Plug>(pad-list)
nmap <silent><leader>ps <Plug>(pad-search)
nnoremap <silent><leader>pt :Pad this<cr>

" ----------------------------------------------------------------------------
" -- jshint ------------------------------------------------------------------

let g:JSHintUpdateWriteOnly=1

" ========================================================================={{{

" vim:foldmethod=marker colorcolumn=80 textwidth=80
