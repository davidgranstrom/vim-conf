"
" vimrc
"
" ==============================================================================
" PLUGINS
" ==============================================================================
" {{{

filetype plugin indent on  " detect plugin filetypes
syntax enable              " syntax highlighting

" vim-plug
call plug#begin('~/.config/nvim/bundle')

" editing
Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'cohama/lexima.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tweekmonster/wstrip.vim'

if has('nvim')
  Plug 'Shougo/deoplete.nvim' | Plug 'Shougo/context_filetype.vim'
  Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
endif

" navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'derekwyatt/vim-fswitch', { 'for': [ 'c', 'cpp', 'objc' ] }
Plug 'justinmk/vim-dirvish'
Plug 'kopischke/vim-fetch'

" util
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'

" language
Plug 'eagletmt/neco-ghc', { 'for': [ 'haskell', 'haskell.tidal' ] }
Plug 'neovimhaskell/haskell-vim', { 'for': [ 'haskell', 'haskell.tidal' ] }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'sheerun/vim-polyglot'

" javascript
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }

" langs not included in polyglot
Plug 'munshkr/vim-tidal', { 'for': 'haskell.tidal' }
Plug 'sophacles/vim-processing', { 'for': 'processing' }
Plug '~/src/sc/supercollider/editors/scvim/'

" color schemes / appearance
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'yuttie/hydrangea-vim'
Plug '~/code/vim/colorschemes/vim-colors-plain'

" misc
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-scriptease', { 'on': 'Runtime' }
Plug 'tpope/vim-unimpaired'
Plug '~/code/vim/nvim-markdown-preview'
Plug '~/code/vim/scvim-reload'
Plug '~/code/vim/vim-dkg'

call plug#end()

let mapleader="\<space>"            " set mapleader
set mouse=a                         " enable mouse

" }}}
" ==============================================================================
" PERFORMANCE
" ==============================================================================
" {{{

" avoid menu.vim (saves ~100ms)
let g:did_install_default_menus = 1
let g:did_install_syntax_menu = 1

" disable netrw, but autoload it for `gx`.
let g:loaded_netrwPlugin = 0
nmap gx <Plug>NetrwBrowseX
nnoremap <silent> <Plug>
      \ NetrwBrowseX :call netrw#BrowseX(
      \ expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),
      \ netrw#CheckIfRemote())<CR>

let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" }}}
" ==============================================================================
" SETTINGS
" ==============================================================================
" {{{

" enable true color for nvim
if has('nvim')
  set inccommand=nosplit " preview changes (:s/) incrementally
  set termguicolors
else
  " put all swap files in one place
  " neovim already does this by default, ~/.local/share/nvim/swap
  set directory^=$HOME/.vim/.swap//
  set ttyfast " assume fast terminal connection
endif

" editing
set backspace=2                     " allow backspacing over indent, eol, and the start of an insert
set virtualedit=all                 " be able to access all areas of the buffer
set hidden                          " be able to hide modified buffers
set complete-=i                     " where to look for auto-completion
set clipboard=unnamed               " yank to system-wide clipboard
set autoread                        " reload buffers changed from the outside
set completeopt-=preview            " don't display scratch buffer for completion
set formatoptions+=rj               " auto insert comments from insert mode, remove comment leader when joining lines

" appearance
set listchars=tab:>-,trail:–,nbsp:• " custom list chars
set scrolloff=4                     " keep a distance of from the cursor when scrolling
set nowrap                          " don't wrap words
set linebreak                       " break at word boundries for wrapped text
set noshowmode                      " get mode indication from lightline instead
set noshowcmd                       " don't display partial commands (g,c etc.)
" set relativenumber
" set number
set sidescroll=1
set sidescrolloff=1
set listchars+=extends:>,precedes:<
set fillchars=vert:│,fold:·

" searching
set ignorecase                      " ignore case in search patterns
set incsearch                       " incrementally match the search
set smartcase                       " overrides 'ignorecase' if search pattern contains an upper char
set showmatch                       " highlight search matches while typing

" misc
set wildmenu                        " enhanced command line completion
set wildignorecase                  " be smart case-sensitive
set diffopt+=vertical               " use vertical diffs by default
set laststatus=2                    " always display a status line
set visualbell                      " turn off error beep/flash
set lazyredraw                      " don't redraw screen for macros

" indenting/formating
" set autoindent                      " indent even if we have no filetype rules
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab                       " use whitespace instead of tabs
set shiftround                      " round indent to multiples of 'shiftwidth'
set nojoinspaces                    " only insert one space after a join command

set background=dark
colorscheme plain

" use par to format text
if executable("par")
  set formatprg=par\ -w80qr
endif

" }}}
" ==============================================================================
" FUNCTIONS
" ==============================================================================
" {{{

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
nnoremap <leader>ev :tabedit $MYVIMRC<cr>

" change to current dir
nnoremap <leader>c :cd %:p:h \| pwd<cr>

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
nnoremap <silent> <C-n> :tabn<cr>
nnoremap <silent> <C-p> :tabp<cr>

" resize windows with arrow-keys
nnoremap <silent><left>  :3wincmd <<cr>
nnoremap <silent><right> :3wincmd ><cr>
nnoremap <silent><up>    :3wincmd +<cr>
nnoremap <silent><down>  :3wincmd -<cr>

" never enter Ex mode
" nnoremap Q q:
nnoremap Q <Nop>
" nnoremap q: <Nop>

" easy renaming
nnoremap <leader>r *``cgn

" don't move cursor after visual selection yank
vnoremap <expr>y "my\"" . v:register . "y`y"

if has('nvim')
  " remap esc in terminal mode
  tnoremap <Esc> <C-\><C-n>

  " navigating terminal splits
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l

  " navigate tab pages (like chrome)
  for i in range(1, 9)
    execute 'nnoremap <silent><A-' . i . '> :tabnext ' . i . ' <cr>'
  endfor

  " save buffer
  nnoremap <A-s> :<C-u>w<cr>
endif

" }}}
" ==============================================================================
" AUTOCMDS
" ==============================================================================
" {{{

augroup vimrc
  autocmd!
augroup END

augroup vimrc
  " vim
  " ---
  " save and source current file
  autocmd FileType vim nnoremap <buffer> <leader>so :w \| so%<cr>

  if has('nvim')
    " make autoread behave as expected (neovim only)
    autocmd FocusGained * if &autoread | silent checktime | endif
    " save last terminal job id
    autocmd TermOpen * let g:last_terminal_job_id = b:terminal_job_id
    " fix a bug where the first line in window is corrupted after resize
    autocmd VimResized * redraw!
  endif

  " c
  " -
  autocmd FileType c setlocal commentstring=\/\/\ %s

  " haskell
  " -------
  let g:haskellmode_completion_ghc = 0
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

  " markdown
  "---------
  autocmd FileType markdown setlocal commentstring=<!--%s-->
  " break undo sequence into smaller chunks for prose
  autocmd FileType markdown inoremap <buffer> . .<c-g>u
  autocmd FileType markdown inoremap <buffer> ? ?<c-g>u
  autocmd FileType markdown inoremap <buffer> ! !<c-g>u
  autocmd FileType markdown inoremap <buffer> , ,<c-g>u

  " javascript
  " ----------
  autocmd FileType javascript.jsx setlocal filetype=javascript
  autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

  autocmd FileType javascript,typescript, setlocal ts=2 sts=2 sw=2
  autocmd FileType css,less,scss,sass setlocal ts=2 sts=2 sw=2

  " hack to make development servers not rebuild twice
  autocmd FileType javascript setlocal nowritebackup

  " python
  " ------
  autocmd FileType python setlocal ts=4 sts=4 sw=4

  " php
  " ---
  function! TogglePhpHtml()
    if &ft == "php"
      set ft=html
    else
      set ft=php
    endif
  endfunction

  autocmd FileType php nnoremap <leader>s :call TogglePhpHtml()<cr>

  autocmd BufEnter,BufNewFile ~/Documents/cv/**/* source ~/code/vim/vim-dkg/scripts/async-make.vim
  autocmd BufEnter,BufNewFile ~/Documents/cv/**/* nnoremap <cr> :<c-u>Make<cr>

  autocmd FileType cmake setlocal commentstring=#%s
augroup END

" }}}
" ==============================================================================
" PLUGIN CONFIGURATION
" ==============================================================================
" {{{

augroup vimrc
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

augroup vimrc
  " enable spell checking in commit messages
  autocmd FileType gitcommit setlocal spell | setlocal spelllang=en
augroup END

" ------------------------------------------------------------------------------
" -- fzf -----------------------------------------------------------------------

" search for file
nnoremap <silent> <leader>t :<C-u>GitFiles<cr>
" select buffers
nnoremap <silent> <leader>b :<C-u>Buffers<cr>
" search in current dir
nnoremap <silent> <leader>g/ :<C-u>Ag<cr>
" search in current buffer
nnoremap <silent> <leader>/ :<C-u>BLines<cr>
" search for current word in pwd
nnoremap <silent> <leader>i :<C-u>call SearchWordWithAg()<cr>
xnoremap <silent> <leader>i :<C-u>call SearchVisualSelectionWithAg()<cr>

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
" -- deoplete ------------------------------------------------------------------

if has('nvim')
  " Enable deoplete on InsertEnter
  let g:deoplete#enable_at_startup = 0
  autocmd! InsertEnter * call deoplete#enable()

  let g:deoplete#enable_smart_case = 1
  let g:deoplete#auto_complete_delay = 15
  " fix issue with large tag files
  let deoplete#tag#cache_limit_size = 5000000

  inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
  endfunction
endif

" ------------------------------------------------------------------------------
" -- Highlighted Yank ----------------------------------------------------------

let g:highlightedyank_highlight_duration = 130

" ------------------------------------------------------------------------------
" -- Ale -----------------------------------------------------------------------

let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \ 'c': ['clang-format','clang'],
      \ 'cpp': ['clang-format','clang'],
      \ 'json': ['jq']
      \ }

" ------------------------------------------------------------------------------
" -- lightline -----------------------------------------------------------------

let g:lightline = {
      \ 'colorscheme': 'monochrome',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \  },
      \  'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \}

" ------------------------------------------------------------------------------
" -- misc ----------------------------------------------------------------------

" tweekmonster/wstrip.vim
let g:wstrip_auto = 1

" supercollider
let g:scFlash = 1

let g:vim_markdown_conceal = 0

augroup vimrc
  let g:LanguageClient_serverCommands = {
        \ 'javascript': ['javascript-typescript-stdio'],
        \ 'javascript.jsx': ['javascript-typescript-stdio'],
        \ 'c': ['cquery'],
        \ 'cpp': ['cquery'],
        \ }

  autocmd FileType javascript nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
  autocmd FileType javascript nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
  " autocmd FileType javascript nnoremap <silent> <leader>r :call LanguageClient_textDocument_rename()<CR>
augroup END

" unimpaired original mapping
nmap co yo

let g:scvim_no_mappings = 1
let g:tmux_navigator_no_mappings = 1

" tmux navigator custom mappings
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>


" fswitch
nmap <silent> <Leader>a :FSHere<cr>

" ===========================================================================
" }}}

" vim:foldmethod=marker colorcolumn=80 textwidth=80
