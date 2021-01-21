"
" init.vim
"
" ==============================================================================
" PLUGINS
" ==============================================================================
" {{{

call plug#begin()

" editing
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'nvim-treesitter/nvim-treesitter'

" navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'justinmk/vim-dirvish'

" util
if has('nvim-0.5')
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
end
Plug 'tpope/vim-fugitive'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" language
Plug '~/code/vim/scnvim'
Plug '~/code/vim/osc.nvim'

" color schemes / appearance
Plug 'pineapplegiant/spaceduck'

" misc
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug '~/code/vim/nvim-markdown-preview'
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

" disable netrw (NOTE: uncomment to download new spell files)
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

if has('mac')
  let g:python_host_prog = '/usr/local/bin/python2'
  let g:python3_host_prog = '/usr/local/bin/python3'
end

" }}}
" ==============================================================================
" SETTINGS
" ==============================================================================
" {{{

" editing
set virtualedit=all      " be able to access all areas of the buffer
set hidden               " be able to hide modified buffers
set clipboard=unnamed    " yank to system-wide clipboard
set completeopt-=preview " don't display scratch buffer for completion
set inccommand=nosplit   " preview changes (:s/) incrementally

" appearance
set scrolloff=4          " keep a distance of from the cursor when scrolling
set nowrap               " don't wrap words
set linebreak            " break at word boundries for wrapped text
set noshowcmd            " don't display partial commands (g,c etc.)
set sidescrolloff=1

" searching
set ignorecase           " ignore case in search patterns
set smartcase            " overrides 'ignorecase'
set showmatch            " highlight search matches while typing

" misc
set wildignorecase       " be smart case-sensitive
set diffopt+=vertical    " use vertical diffs by default
set lazyredraw           " don't redraw screen for macros

" indenting/formating
set tabstop=2
set softtabstop=2
set shiftwidth=2
set copyindent           " copy indent chars from previous line
set expandtab            " use whitespace instead of tabs
set shiftround           " round indent to multiples of 'shiftwidth'
set nojoinspaces         " only insert one space after a join command

set termguicolors
colorscheme spaceduck
hi! link Comment Folded

" }}}
" ==============================================================================
" FUNCTIONS
" ==============================================================================
" {{{

" delete trailing whitespace in the whole buffer
function! s:delete_trailing_ws()
  normal! m`
  %s/\s\+$//ge
  normal! ``
endfunction

command! DeleteTrailingWS call <sid>delete_trailing_ws()

" format json
if executable('jq')
  com! JSONPretty %!jq '.'
  com! JSONUgly %!jq -c '.'
else
  com! JSONPretty %!python -m json.tool
endif

" }}}
" ==============================================================================
" KEY MAPPINGS
" ==============================================================================
" {{{

" edit vimrc
nnoremap <leader>ev :tabedit $MYVIMRC<cr>

" change to current dir
nnoremap <leader>c :cd %:p:h \| pwd<cr>

" save buffer
nnoremap <A-s> :<c-u>w<cr>

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

" edit current buffer in a new tab
nnoremap <silent><leader>z :tabedit!%<cr>

" resize windows with arrow-keys
nnoremap <silent><left>  :3wincmd <<cr>
nnoremap <silent><right> :3wincmd ><cr>
nnoremap <silent><up>    :3wincmd +<cr>
nnoremap <silent><down>  :3wincmd -<cr>

" never enter Ex mode
nnoremap Q <Nop>

" easy renaming
nnoremap <leader>r *``cgn

" don't move cursor after visual selection yank
vnoremap <expr>y "my\"" . v:register . "y`y"

" remap esc in terminal mode
tnoremap <Esc> <C-\><C-n>

" navigate from terminal buffers
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

" }}}
" ==============================================================================
" AUTOCMDS
" ==============================================================================
" {{{

augroup vimrc
  autocmd!
augroup END

augroup vimrc_filetype
  autocmd!

  " c/cpp
  " autocmd BufEnter,BufReadPre,BufNewFile *.h,*.c setlocal filetype=c.doxygen
  autocmd BufEnter,BufReadPre,BufNewFile *.h setlocal filetype=c

  " c#
  autocmd FileType cs set tabstop=4 softtabstop=4 shiftwidth=4

  " markdown
  autocmd FileType markdown setlocal commentstring=<!--%s-->
  " break undo sequence into smaller chunks for prose
  autocmd FileType markdown inoremap <buffer> . .<c-g>u
  autocmd FileType markdown inoremap <buffer> ? ?<c-g>u
  autocmd FileType markdown inoremap <buffer> ! !<c-g>u
  autocmd FileType markdown inoremap <buffer> , ,<c-g>u

  " javascript
  autocmd FileType javascript.jsx setlocal filetype=javascript
  autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

  " hack to make development servers not rebuild twice
  autocmd FileType javascript setlocal nowritebackup

  " python
  autocmd FileType python setlocal ts=4 sts=4 sw=4

  " cmake
  autocmd FileType cmake setlocal commentstring=#%s
augroup END

" }}}
" ==============================================================================
" Lua
" ==============================================================================
" {{{

if has('nvim-0.5')
  lua require'dkg.config.lsp'
  lua require'dkg.config.treesitter'
  lua require'dkg.config.telescope'
end

" }}}
" ==============================================================================
" PLUGIN CONFIGURATION
" ==============================================================================
" {{{

" ------------------------------------------------------------------------------
" -- completion-nvim -----------------------------------------------------------

" enable completion-nvim for all buffers
if has('nvim-0.5')
  augroup completion_vimrc
    autocmd!
    autocmd BufEnter * lua require'completion'.on_attach()
  augroup END
endif

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_auto_change_source = 1
let g:completion_enable_auto_hover = 0
let g:completion_trigger_keyword_length = 3

" ------------------------------------------------------------------------------
" -- Surround  -----------------------------------------------------------------

xmap s <plug>VSurround

" ------------------------------------------------------------------------------
" -- Fugitive  -----------------------------------------------------------------

nnoremap <leader>fs :Gstatus<cr>
nnoremap <F5> :Gblame<cr>

augroup vimrc_git
  autocmd!
  " enable spell checking in commit messages
  autocmd FileType gitcommit setlocal spell | setlocal spelllang=en
augroup END

" ------------------------------------------------------------------------------
" -- telescope -----------------------------------------------------------------

nnoremap <silent> <leader>t <cmd>Telescope git_files<cr>
nnoremap <silent> <leader>b <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>g <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>i <cmd>Telescope grep_string<cr>

" ------------------------------------------------------------------------------
" -- scnvim --------------------------------------------------------------------

let g:scnvim_scdoc = 1
nnoremap <leader>st <cmd>SCNvimStart<cr>
nmap <leader>sk <Plug>(scnvim-recompile)

" ------------------------------------------------------------------------------
" -- tmux-navigator ------------------------------------------------------------

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>

" ------------------------------------------------------------------------------
" -- misc ----------------------------------------------------------------------

" dont' conceal text in markdown files
let g:vim_markdown_conceal = 0

" unimpaired original mapping
nmap co yo

let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

augroup hlyank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="MatchParen", timeout=80}
augroup END

" ===========================================================================
" }}}

" vim:foldmethod=marker colorcolumn=80 textwidth=80
