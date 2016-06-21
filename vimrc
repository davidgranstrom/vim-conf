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

" enable true color for nvim
if has('nvim')
    set termguicolors
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
if has('nvim')
    Plug 'Shougo/deoplete.nvim'
else
    Plug 'ervandew/supertab'
endif

" navigation
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'justinmk/vim-dirvish'
Plug 'kopischke/vim-fetch'
Plug 'vim-scripts/matchit.zip'

" util
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neomake/neomake'
Plug 'Yggdroot/indentLine'
Plug 'simnalamburt/vim-mundo'
if has('nvim')
    Plug 'neovim/node-host', { 'do' : 'npm install' }
endif

if has('nvim')
    " make autoread behave as expected (neovim only)
    au FocusGained * if &autoread | silent checktime | endif
else
    Plug 'tmux-plugins/vim-tmux-focus-events'
endif

" language
Plug 'sheerun/vim-polyglot'

" javascript
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'carlitux/deoplete-ternjs'

" langs not included in polyglot
Plug 'ryotakato/unite-outline-objc', { 'for': 'obj-c' }
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

" misc
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-scriptease', { 'on': 'Runtime' }
Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_mac.mak' }
Plug 'tpope/vim-unimpaired'
Plug 'davidgranstrom/vim-dkg'

" unused
" Plug 'fmoralesc/vim-pad'
" Plug 'Quramy/tsuquyomi', { 'for': 'typescript', 'do': 'make -f make_mac.mak' }
" Plug 'kassio/neoterm'
" Plug 'derekwyatt/vim-fswitch'
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
" Plug 'scrooloose/nerdtree'
" Plug 'vim-airline/vim-airline'
" Plug 'gavocanov/vim-js-indent', { 'for': 'javascript' }
" Plug 'marijnh/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
" Plug 'othree/yajs.vim', { 'for': 'javascript' }
" Plug 'othree/jspc.vim', { 'for': 'javascript' }
" Plug 'moll/vim-node', { 'for': 'javascript' }

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
set formatoptions+=rj               " auto insert comments from insert mode,
                                    " remove comment leader when joining lines

" appearance
" set fillchars=                      " remove the fillchars from folds and splits
set listchars=tab:>-,trail:–,nbsp:• " custom list chars
set nostartofline                   " keep the cursor at the current column when moving
set scrolloff=8                     " keep a distance of from the cursor when scrolling
set nowrap                          " don't wrap words
set linebreak                       " break at word boundries for wrapped text
set list                            " show unprintable characters
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
    let g:gruvbox_contrast_dark='hard'
    colorscheme gruvbox

    if has("gui_macvim")
        set transparency=3
    endif

    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h14,Monospace
    " style guicursor
    set guicursor=n-c-v:block-Cursor-blinkOn0

    " get rid of all scrollbars and the toolbar
    set guioptions-=TRLrlbme
    " use console dialogs for simple choices
    set guioptions+=c
else
    set background=dark
    colorscheme hybrid
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
nnoremap <F1> <Esc>

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
nnoremap <silent><leader>n :tabnew \| Files<cr>

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

    " javascript
    augroup javascript
        autocmd!
        autocmd FileType javascript setlocal ts=2 sts=2 sw=2
        let g:neomake_javascript_enabled_makers = ['jshint', 'jscs']
        " autocmd InsertLeave *.ts Neomake
        " autocmd BufWritePost *.ts Neomake
        autocmd BufWritePost *.js Neomake
        autocmd InsertLeave *.js Neomake
    augroup END

    " typescript
    " augroup typescript
    "     autocmd!
    "     autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
    "     autocmd FileType typescript nmap <buffer> <Leader>k :<C-u>echo tsuquyomi#hint()<CR>
    "     autocmd FileType typescript setlocal ts=2 sts=2 sw=2
    "     let g:neomake_javascript_enabled_makers = ['tslint']
    "     autocmd FileType typescript setlocal makeprg=tslint
    "     autocmd InsertLeave *.ts Neomake
    "     autocmd BufWritePost *.ts Neomake
    " augroup END

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
        " neomake
        if has('nvim')
            " let g:neomake_javascript_enabled_makers = ['flow']
            autocmd FileType javascript setlocal makeprg=jshint
            autocmd InsertLeave *.js Neomake
            autocmd BufWritePost *.js Neomake
        endif
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

let g:NERDTreeHijackNetrw=1

" toggle
nnoremap <silent> <F2> :NERDTreeToggle ~/<CR>
nnoremap <silent> <F3> :NERDTreeFind<CR>

" ----------------------------------------------------------------------------
" -- Unite  ------------------------------------------------------------------

let g:unite_source_history_yank_enable = 1
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

nnoremap <leader>o  :<C-u>Unite -direction=topleft outline<cr>

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

let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 10

" ----------------------------------------------------------------------------
" -- FSwitch  ----------------------------------------------------------------

nnoremap <silent> <Leader>s :FSSplitAbove<cr>
nnoremap <silent> <Leader>a :FSHere<cr>

" ------------------------------------------------------------------------------
" -- indentLine  ---------------------------------------------------------------

let g:indentLine_char = '┊'

" ------------------------------------------------------------------------------
" -- fzf -----------------------------------------------------------------------

let g:fzf_nvim_statusline = 0 " disable statusline overwriting

" search for file
nnoremap <silent> <leader>t :<C-u>GitFiles<cr>
" select buffers
nnoremap <silent> <leader>b :<C-u>Buffers<cr>
" search in whole project
nnoremap <silent> <leader>g/ :<C-u>Ag<cr>
" search in loaded buffers
nnoremap <silent> <leader>a/ :<C-u>Lines<cr>
" search in current buffer
nnoremap <silent> <leader>/ :<C-u>BLines<cr>
" search for current word in pwd
nnoremap <silent> <leader>f :<C-u>call SearchWordWithAg()<cr>
vnoremap <silent> <leader>f :<C-u>call SearchVisualSelectionWithAg()<cr>
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
" -- dirvish -------------------------------------------------------------------

" augroup dirvish
"     autocmd!
"     autocmd FileType dirvish setlocal bufhidden=wipe

"     autocmd FileType dirvish nnoremap <buffer> t
"         \ :tabnew <C-R>=fnameescape(getline('.'))<CR><CR>

"     autocmd FileType dirvish nnoremap <buffer> gh
"         \ :set ma<bar>g@\v/\.[^\/]+/?$@d<cr>:set noma<cr>

"     autocmd FileType dirvish nnoremap <buffer> q
"         \ :bd!<cr>
" augroup END

" let g:dirvish_relative_paths = 1

" nnoremap <silent> <F2> :15split \| Dirvish ~/<cr>
" nnoremap <silent> <F3> :15split \| Dirvish %<cr>

" ------------------------------------------------------------------------------
" -- vim-tern ------------------------------------------------------------------

let tern_show_argument_hints = 0
let tern_show_signature_in_pum = 1

" ------------------------------------------------------------------------------
" -- deoplete ------------------------------------------------------------------

if has('nvim')
    let g:deoplete#enable_at_startup = 1

    inoremap <silent> <expr> <Tab>
        \ pumvisible() ? "\<C-n>" :
        \ deoplete#mappings#manual_complete()

    " inoremap <expr><Tab> deoplete#mappings#manual_complete()
    inoremap <expr><C-h> deolete#mappings#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
endif

" ==========================================================================={{{
" vim:foldmethod=marker colorcolumn=80 textwidth=80
