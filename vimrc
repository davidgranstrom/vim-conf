"
" vimrc
"
" ==============================================================================
" GLOBAL
" ==============================================================================
" {{{

filetype plugin indent on  " detect plugin filetypes
syntax enable              " syntax highlighting

" vim-plug
call plug#begin('~/.vim/bundle')

" editing
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'cohama/lexima.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tweekmonster/wstrip.vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim' | Plug 'Shougo/context_filetype.vim'
  " Plug 'roxma/nvim-completion-manager'
  " Plug 'roxma/nvim-cm-tern', {'do': 'npm install'}
  Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
endif

" navigation
Plug 'justinmk/vim-dirvish'
Plug 'kopischke/vim-fetch'
Plug 'vim-scripts/matchit.zip'

" util
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'simnalamburt/vim-mundo'
Plug 'kassio/neoterm'
if has('nvim')
  Plug 'bfredl/nvim-miniyank'
endif

" language
Plug 'sheerun/vim-polyglot'
Plug 'neovimhaskell/haskell-vim', { 'for': [ 'haskell', 'haskell.tidal' ] }
Plug 'eagletmt/neco-ghc', { 'for': [ 'haskell', 'haskell.tidal' ] }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }

" clojure
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'clojure-vim/async-clj-omni', { 'for': 'clojure' }
" Plug 'clojure-vim/acid.nvim'

" javascript
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }

" langs not included in polyglot
Plug 'sophacles/vim-processing', { 'for': 'processing' }
" Plug 'supercollider/scvim'
Plug '~/src/sc3/supercollider/editors/scvim/'
Plug '~/code/vim/scvim-reload'
Plug 'munshkr/vim-tidal', { 'for': 'haskell.tidal' }

" color schemes / appearance
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'trevordmiller/nova-vim'

Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug '~/code/vim/colors/preto'

" misc
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-scriptease', { 'on': 'Runtime' }
Plug '~/code/vim/vim-dkg'

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer'), 'for': 'markdown' }

call plug#end()

let mapleader="\<space>"            " set mapleader
set mouse=a                         " enable mouse

" enable true color for nvim
if has('nvim')
  set inccommand=nosplit " preview changes (:s/) incrementally
  set termguicolors
else
  " neovim already does this by default, ~/.local/share/nvim/swap
  set directory^=$HOME/.vim/.swap//   " put all swap files in one place
  set ttyfast " assume fast terminal connection
endif

" editing
set backspace=2                     " allow backspacing over indent, eol, and the start of an insert
set virtualedit=all                 " be able to access all areas of the buffer
set hidden                          " be able to hide modified buffers
" set complete-=i                     " where to look for auto-completion
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
set relativenumber
set number

" searching
set ignorecase                      " ignore case in search patterns
set incsearch                       " incrementally match the search
set smartcase                       " overrides 'ignorecase' if search pattern contains an upper char
set showmatch                       " highlight search matches while typing

" misc
set wildmenu                        " enhanced command line completion
set wildignorecase                  " be smart case-sensitive
" set wildmode=list:full
set diffopt+=vertical               " use vertical diffs by default
set laststatus=2                    " always display a status line
set visualbell                      " turn off error beep/flash
set lazyredraw                      " don't redraw screen for macros
set noshowcmd                       " don't display partial commands (g,c etc.)

" indenting/formating
set autoindent                      " indent even if we have no filetype rules
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab                       " use whitespace instead of tabs
set shiftround                      " round indent to multiples of 'shiftwidth'
set nojoinspaces                    " only insert one space after a join command

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
  colorscheme nova
endif

" use par to format text
if executable("par")
  set formatprg=par\ -w80qr
endif

" }}}
" ==============================================================================
" FUNCTIONS
" ==============================================================================
" {{{

" toggle location list
nnoremap <silent><leader>l :lw<cr>

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
nnoremap <leader>ev :tabedit ~/.vim/vimrc<cr>

augroup vimrc_reload
  autocmd!
  " save and source current file
  autocmd FileType vim nnoremap <buffer> <leader>so :w \| so%<cr>
augroup END

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
" nnoremap <silent><leader>n :tabnew \| Files<cr>

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" inoremap <C-U> <C-G>u<C-U>

" resize windows with arrow-keys
nnoremap <silent><left>  :3wincmd <<cr>
nnoremap <silent><right> :3wincmd ><cr>
nnoremap <silent><up>    :3wincmd +<cr>
nnoremap <silent><down>  :3wincmd -<cr>

" never enter Ex mode
" nnoremap Q q:
nnoremap Q <Nop>

" easy renaming
nnoremap <leader>r *``cgn

if has('nvim')
  " remap esc in terminal mode
  tnoremap <Esc> <C-\><C-n>

  " navigating terminal splits
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l

  " navigate window splits
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

  " always enter insert mode
  " autocmd! BufWinEnter,WinEnter term://* startinsert
  " autocmd! BufLeave term://* stopinsert
endif

" }}}
" ==============================================================================
" AUTOCMDS
" ==============================================================================
" {{{

if has('nvim')
  " make autoread behave as expected (neovim only)
  au! FocusGained * if &autoread | silent checktime | endif
endif

" c
augroup dkg_c
  autocmd!
  autocmd FileType c setlocal commentstring=\/\/\ %s
augroup END

" " haskell
" augroup dkg_haskell
"   autocmd!
"   let g:haskellmode_completion_ghc = 0
"   autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
" augroup END

" markdown
augroup dkg_markdown
  autocmd!
  " autocmd BufEnter,BufWinEnter,BufNewFile,BufRead *.md, *.markdown set filetype=markdown
  autocmd FileType markdown setlocal commentstring=<!--%s-->
  " break undo sequence into smaller chunks for prose
  autocmd FileType markdown inoremap <buffer> . .<c-g>u
  autocmd FileType markdown inoremap <buffer> ? ?<c-g>u
  autocmd FileType markdown inoremap <buffer> ! !<c-g>u
  autocmd FileType markdown inoremap <buffer> , ,<c-g>u
augroup END

" javascript
augroup dkg_javascript
  autocmd!
  autocmd FileType javascript.jsx setlocal filetype=javascript
  autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
  autocmd FileType javascript,typescript, setlocal ts=2 sts=2 sw=2
  autocmd FileType css,less,scss,sass setlocal ts=2 sts=2 sw=2
  autocmd FileType javascript setlocal nowritebackup
  autocmd FileType javascript nnoremap <buffer><leader>f :ALEFix<cr>
  autocmd FileType javascript nnoremap <buffer><silent> K :call LanguageClient_textDocument_hover()<CR>
  autocmd FileType javascript nnoremap <buffer><silent> gd :call LanguageClient_textDocument_definition()<CR>
  autocmd FileType javascript nnoremap <buffer><silent> <leader>r :call LanguageClient_textDocument_rename()<CR>
augroup END

" python
augroup dkg_python
  autocmd!
  autocmd FileType python setlocal ts=4 sts=4 sw=4
augroup END

" fugitive
augroup dkg_fugitive
  autocmd!
  " enable spell checking in commit messages
  autocmd FileType gitcommit setlocal spell | setlocal spelllang=en
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

if has('nvim')
  augroup dkg_terminal
    au!
    au TermOpen * let g:last_terminal_job_id = b:terminal_job_id
  augroup END
endif

" }}}
" ==============================================================================
" PLUGIN CONFIGURATION
" ==============================================================================
" {{{

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
" -- Mundo  --------------------------------------------------------------------

nnoremap <F4> :MundoToggle<CR>

" ------------------------------------------------------------------------------
" -- EasyAlign  ----------------------------------------------------------------

vmap <leader>a <Plug>(EasyAlign)
" For normal mode, with Vim movement (e.g. <Leader>aip)
" nmap <leader><space> <Plug>(EasyAlign)

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
" -- deoplete ------------------------------------------------------------------

if has('nvim')
  let g:deoplete#enable_smart_case = 1
  let g:deoplete#auto_complete_delay = 15
  " fix issue with large tag files
  let deoplete#tag#cache_limit_size = 5000000

  " Enable deoplete on InsertEnter
  let g:deoplete#enable_at_startup = 0
  autocmd! InsertEnter * call deoplete#enable()

  inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr><C-h> deolete#mappings#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

  let g:deoplete#sources#ternjs#tern_bin = '/usr/local/bin/tern'
  let g:deoplete#sources#ternjs#timeout = 1
  " Whether to include the types of the completions in the result data. Default: 0
  let g:deoplete#sources#ternjs#types = 1
endif

" ------------------------------------------------------------------------------
" -- Highlighted Yank ----------------------------------------------------------

let g:highlightedyank_highlight_duration = 130

" ------------------------------------------------------------------------------
" -- Ale -----------------------------------------------------------------------

let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_fixers = { 'javascript': ['eslint'] }
nmap <leader><space> <Plug>(ale_fix)
" let g:ale_linters = {'cpp': ['cppcheck']}
" let g:ale_c_cppcheck_options = '--enable=style -I../include'

" ------------------------------------------------------------------------------
" -- Neoterm -------------------------------------------------------------------
if has('nvim')
  let g:neoterm_size = 15
  let g:neoterm_autoscroll = 1

  function! ToggleTerm()
    if &buftype != 'terminal'
      execute 'Ttoggle'
      wincmd j
      startinsert
    else
      stopinsert
      execute 'Ttoggle'
    endif
  endfunction

  nnoremap <silent> <A-t> :call ToggleTerm()<cr>
  tnoremap <silent> <A-t> <C-\><C-n>:call ToggleTerm()<cr>
  nnoremap <silent> <F8> :TREPLSendFile<cr>
  nnoremap <silent> <A-e> :TREPLSendLine<cr>
  vnoremap <silent> <A-e> :TREPLSendSelection<cr>
endif

" ------------------------------------------------------------------------------
" -- misc ----------------------------------------------------------------------

let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

" tweekmonster/wstrip.vim
let g:wstrip_auto = 1

" supercollider
let g:scFlash = 1

let g:vim_markdown_conceal = 0

let g:racer_cmd = $HOME . "/.cargo/bin/racer"
au! FileType rust nmap gd <Plug>(rust-def)
au! FileType rust nmap K <Plug>(rust-doc)

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['~/src/javascript-typescript-langserver/lib/language-server-stdio.js'],
    \ }

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'

" miniyank
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>p <Plug>(miniyank-cycle)

" ==========================================================================={{{
" vim:foldmethod=marker colorcolumn=80 textwidth=80
