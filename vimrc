"
" vimrc
"
" ==============================================================================
" GLOBAL
" ==============================================================================
" {{{

filetype plugin indent on  " detect plugin filetypes
syntax enable              " syntax highlighting

" enable true color for nvim
if has('nvim')
    set termguicolors
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

" vim-plug
call plug#begin('~/.vim/bundle')

" editing
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'cohama/lexima.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tommcdo/vim-exchange'
if has('nvim')
    " Plug 'Shougo/deoplete.nvim' | Plug 'Shougo/context_filetype.vim'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } | Plug 'Shougo/context_filetype.vim'
else
    Plug 'ervandew/supertab'
endif

" navigation
Plug 'justinmk/vim-dirvish'
Plug 'kopischke/vim-fetch'
Plug 'vim-scripts/matchit.zip'
Plug 'justinmk/vim-sneak'

" util
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'neomake/neomake'
Plug 'w0rp/ale'
" Plug 'Yggdroot/indentLine'
Plug 'simnalamburt/vim-mundo'
Plug 'jalvesaq/vimcmdline'
Plug 'ludovicchabant/vim-gutentags'
Plug 'metakirby5/codi.vim'
Plug 'mhinz/vim-grepper'
Plug 'junegunn/vim-slash'
Plug 'alok/notational-fzf-vim'

if has('nvim')
    Plug 'neovim/node-host', { 'do' : 'npm install' }
    " make autoread behave as expected (neovim only)
    au FocusGained * if &autoread | silent checktime | endif
endif

" language
Plug 'sheerun/vim-polyglot'
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }

" javascript
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript' }

" langs not included in polyglot
Plug 'sophacles/vim-processing', { 'for': 'processing' }
Plug 'sbl/scvim'

" color schemes / appearance
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'tomasr/molokai'
Plug 'freeo/vim-kalisi'
Plug 'w0ng/vim-hybrid'
Plug 'NLKNguyen/papercolor-theme'
Plug 'mhartington/oceanic-next'
Plug 'jacoborus/tender'
Plug 'machakann/vim-highlightedyank'

" misc
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-scriptease', { 'on': 'Runtime' }
Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_mac.mak' }
Plug 'tpope/vim-unimpaired'
Plug 'davidgranstrom/vim-dkg'
Plug 'tweekmonster/nvim-api-viewer'

" unused
" Plug 'fmoralesc/vim-pad'
" Plug 'Quramy/tsuquyomi', { 'for': 'typescript', 'do': 'make -f make_mac.mak' }
" Plug 'derekwyatt/vim-fswitch'
" Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
" Plug 'scrooloose/nerdtree'
" Plug 'vim-airline/vim-airline'
" Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' }
" Plug 'marijnh/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
" Plug 'othree/yajs.vim', { 'for': 'javascript' }
" Plug 'othree/jspc.vim', { 'for': 'javascript' }
" Plug 'moll/vim-node', { 'for': 'javascript' }
" Plug 'Shougo/unite.vim'
" Plug 'Shougo/unite-outline'
" Plug 'ryotakato/unite-outline-objc', { 'for': 'obj-c' }
" Plug 'tmux-plugins/vim-tmux-focus-events'
" Plug 'roxma/vim-tmux-clipboard'
" Plug 'kassio/neoterm'

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
set completeopt-=preview            " don't display scratch buffer for completion
set inccommand=nosplit              " preview changes (:s/) incrementally
set formatoptions+=rj               " auto insert comments from insert mode,
                                    " remove comment leader when joining lines

" appearance
" set fillchars=                      " remove the fillchars from folds and splits
set listchars=tab:>-,trail:–,nbsp:• " custom list chars
set nostartofline                   " keep the cursor at the current column when moving
set scrolloff=4                     " keep a distance of from the cursor when scrolling
set nowrap                          " don't wrap words
set linebreak                       " break at word boundries for wrapped text
" set list                            " show unprintable characters
set relativenumber

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
set regexpengine=0                  " auto-switch regexp engines
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
    let g:gruvbox_contrast_dark='hard'
    colorscheme gruvbox

    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h14,Monospace
    " style guicursor
    set guicursor=n-c-v:block-Cursor-blinkOn0
    " get rid of all scrollbars and the toolbar
    set guioptions-=TRLrlbme
    " use console dialogs for simple choices
    set guioptions+=c
else
    set background=dark
    colorscheme tender
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

" delete trailing whitespace in the whole buffer
function! DeleteTrailingWS()
  normal! m`
  %s/\s\+$//ge
  normal! ``
endfunction

com! DeleteTrailingWS :call DeleteTrailingWS()
nnoremap _$ :DeleteTrailingWS<cr>
nnoremap __ :s/\s\+$//ge<cr>

" format json
if executable('jq')
    com! JSONPretty %!jq '.'
    com! JSONUgly %!jq -c '.'
else
    com! JSONPretty %!python -m json.tool
endif

" justify selected text
com! -nargs=0 -range Justify '<,'>!par \-w80j

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
    autocmd FileType vim nnoremap <buffer> <leader>so :w<cr>:so%<cr>
augroup END

" change to current dir
nnoremap <leader>c :cd %:p:h\|pwd<cr>

" unmap help, and replace with <Esc>
noremap <F1> <Esc>
inoremap <F1> <Esc>

" exit insert mode
imap jk <Esc>

" easier navigation in wrapped text
nnoremap j gj
nnoremap k gk

" make horizontal scrolling easier
nnoremap <C-l> 10zl
nnoremap <C-h> 10zh

" move a step to the right in insert mode
inoremap <C-l> <C-o>l

" make Y behave like D
nnoremap Y y$

" always send empty lines into the blackhole register
nnoremap <expr> dd empty(getline('.')) ? '"_dd' : 'dd'

" paste last yanked item
nnoremap gp "0p
xnoremap gp "0p

" move to the first non-blank character of the line
nnoremap <BS> ^

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
" nnoremap <silent><leader>n :tabnew \| Files<cr>

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

nnoremap Q q:

if has('nvim')
    " remap esc in terminal mode
    tnoremap <Esc> <C-\><C-n>
    " navigating terminal splits
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
    " navigate tab pages (like chrome)
    for i in range(1, 9)
        execute 'nnoremap <silent><A-' . i . '> :tabnext ' . i . ' <cr>'
    endfor

    " save buffer
    nnoremap <A-s> :<C-u>w<cr>

    " augroup neovim
    "     au!
    "     au BufEnter * if &buftype == 'terminal' | :startinsert | endif
    " augroup   END

    " visor style terminal buffer
    let s:termbuf = 0
    function! ToggleTerm()
        topleft 15 split
        try
            exe 'buffer' . s:termbuf
            startinsert
        catch
            terminal
            let s:termbuf=bufnr('%')
            tnoremap <buffer> <A-t>  <C-\><C-n>:close<cr>
        endtry
    endfunction

    com! ToggleTerm call ToggleTerm()
    nnoremap <A-t> :ToggleTerm<cr>

    " toggle calculator
    let s:calcbuf = 0

    function! ToggleCalculator()
        topleft 10 split
        try
            exe 'buffer' . s:calcbuf
            startinsert
        catch
            terminal calc
            let s:calcbuf=bufnr('%')
            tnoremap <buffer> <A-c> <C-\><C-n>:close<cr>
        endtry
    endfunction

    com! ToggleCalculator call ToggleCalculator()
    nnoremap <A-c> :ToggleCalculator<cr>
endif

" }}}
" ==============================================================================
" LANGUAGE SETTINGS
" ==============================================================================
" {{{

" supercollider
source ~/.vim/bundle/vim-dkg/supercollider/scvim_init.vim

if has("autocmd")
    " neomake
    " augroup dkg_neomake
    "     autocmd!
    "     autocmd BufWritePost * Neomake
    " augroup END

    " c
    augroup dkg_c
        autocmd!
        autocmd FileType c set commentstring=\/\/\ %s
    augroup END

    " haskell
    augroup dkg_haskell
        autocmd!
        autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
    augroup END

    " markdown
    augroup dkg_markdown
        autocmd!
        autocmd BufEnter,BufWinEnter,BufNewFile,BufRead *.md,*.markdown set filetype=markdown
        autocmd BufEnter,BufWinEnter,BufNewFile,BufRead *.md,*.markdown set commentstring=<!--%s-->
    augroup END

    " javascript
    augroup dkg_javascript
        autocmd!
        autocmd FileType javascript.jsx setlocal filetype=javascript
        autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
        autocmd FileType javascript,typescript, setlocal ts=2 sts=2 sw=2
        autocmd FileType css,less setlocal ts=2 sts=2 sw=2
    augroup END

    " python
    augroup dkg_python
        autocmd!
        autocmd FileType python setlocal ts=4 sts=4 sw=4
    augroup END

    " fugitive
    augroup dkg_fugitive
        autocmd!
        autocmd BufEnter,BufWinEnter */.git/index set spell | set spelllang=en
    augroup END

    " php
    function! TogglePhpHtml()
        if &ft == "php"
            set ft=html
        else
            set ft=php
        endif
    endfunction

    augroup dkg_php
        autocmd!
        autocmd FileType php nnoremap <leader>s :call TogglePhpHtml()<cr>
        " autocmd FileType html nnoremap <leader>s :set ft=html
    augroup END
endif

" }}}
" ==============================================================================
" PLUGIN CONFIGURATION
" ==============================================================================
" {{{

" -- Dirvish  ------------------------------------------------------------------

function! OpenDirvish()
    if &filetype == ''
        Dirvish
    else
        Dirvish %
    endif
endfunction

nnoremap <silent> <F1> :call OpenDirvish()<cr>

augroup my_dirvish_autocmds
    autocmd!
    " Map t to "open in new tab".
    autocmd FileType dirvish
    \  nnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>
    \ |xnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>

    " Enable :Gstatus and friends.
    autocmd FileType dirvish call fugitive#detect(@%)

    " Map CTRL-R to reload the Dirvish buffer.
    autocmd FileType dirvish nnoremap <buffer> <C-R> :<C-U>Dirvish %<CR>

    " Map gh to hide 'hidden' files.
    autocmd FileType dirvish nnoremap <buffer> gh 
        \ :g@\v/\.[^\/]+/?$@d<cr>

    autocmd FileType dirvish nnoremap <buffer> s :<C-U>sort r /[^\/]$/<CR>
    autocmd FileType dirvish nnoremap <buffer> S :<C-U>sort r /\/$/<CR>
augroup END

" ------------------------------------------------------------------------------
" -- SuperTab  -----------------------------------------------------------------

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabCrMapping = 0

" ------------------------------------------------------------------------------
" -- Mundo  --------------------------------------------------------------------

nnoremap <F4> :MundoToggle<CR>

" ------------------------------------------------------------------------------
" -- EasyAlign  ----------------------------------------------------------------

vmap <leader><space> <Plug>(EasyAlign)
" For normal mode, with Vim movement (e.g. <Leader>aip)
nmap <leader><space> <Plug>(EasyAlign)

" ------------------------------------------------------------------------------
" -- UltiSnips  ----------------------------------------------------------------

let g:UltiSnipsListSnippets        = "<c-\\>"
let g:UltiSnips_Author             = "David Granström"
let g:UltiSnipsExpandTrigger       = "<C-j>"
let g:UltiSnipsJumpForwardTrigger  = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsUsePythonVersion    = 2
if has('nvim')
    let g:UltiSnipsUsePythonVersion = 3
endif


" ------------------------------------------------------------------------------
" -- Surround  -----------------------------------------------------------------

xmap s <plug>VSurround

" ------------------------------------------------------------------------------
" -- Fugitive  -----------------------------------------------------------------

nnoremap <Leader>fs :Gstatus<CR><C-w>K
nnoremap <F5> :Gblame<cr>

" ------------------------------------------------------------------------------
" -- indentLine  ---------------------------------------------------------------

" let g:indentLine_char = '┊'

" ------------------------------------------------------------------------------
" -- fzf -----------------------------------------------------------------------

" search for file
nnoremap <silent> <leader>t :<C-u>GitFiles<cr>
" select buffers
nnoremap <silent> <leader>b :<C-u>Buffers<cr>
" search in current dir
nnoremap <silent> <leader>g/ :<C-u>Ag<cr>
" search in loaded buffers
nnoremap <silent> <leader>a/ :<C-u>Lines<cr>
" search in current buffer
nnoremap <silent> <leader>/ :<C-u>BLines<cr>
" search for current word in pwd
nnoremap <silent> <leader>i :<C-u>call SearchWordWithAg()<cr>
xnoremap <silent> <leader>i :<C-u>call SearchVisualSelectionWithAg()<cr>
" filter (vim) commands
nnoremap <silent> <leader>: :<C-u>Commands<cr>

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
endfunction

" ------------------------------------------------------------------------------
" -- vim-tern ------------------------------------------------------------------

let tern_show_argument_hints = 0
let tern_show_signature_in_pum = 1

" ------------------------------------------------------------------------------
" -- deoplete ------------------------------------------------------------------

if has('nvim')
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1

    inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr><C-h> deolete#mappings#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
endif

" ------------------------------------------------------------------------------
" -- Highlighted Yank ----------------------------------------------------------

let g:highlightedyank_highlight_duration = 100

" ------------------------------------------------------------------------------
" -- Neomake -------------------------------------------------------------------

" let g:neomake_open_list = 2
" let g:neomake_javascript_enabled_makers = ['eslint']

" ------------------------------------------------------------------------------
" -- Grepper -------------------------------------------------------------------

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" ------------------------------------------------------------------------------
" -- Ale -----------------------------------------------------------------------

let g:ale_linters = {'javascript': ['eslint']}

" ------------------------------------------------------------------------------
" -- Notational-fzf ------------------------------------------------------------

nnoremap <leader>n :NV<cr>
let g:nv_directories = ['~/wiki']

" ------------------------------------------------------------------------------
" -- misc ----------------------------------------------------------------------

let g:vim_markdown_conceal = 0

" ==========================================================================={{{
" vim:foldmethod=marker colorcolumn=80 textwidth=80
