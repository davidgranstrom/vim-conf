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
Plug 'Shougo/deoplete.nvim'
Plug 'SirVer/ultisnips'
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'justinmk/vim-dirvish'

" util
" Plug 'w0rp/ale'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lsp'
Plug 'tpope/vim-fugitive'

" language
Plug 'sheerun/vim-polyglot'
" extra
Plug '~/code/vim/scnvim'

" color schemes / appearance
Plug 'machakann/vim-highlightedyank'
Plug 'andreypopp/vim-colors-plain'

" misc
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug '~/code/vim/nvim-markdown-preview'
Plug '~/code/vim/vim-dkg'

call plug#end()

augroup vimrc
  autocmd!
augroup END

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

" disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

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
set scrolloff=4                     " keep a distance of from the cursor when scrolling
set nowrap                          " don't wrap words
set linebreak                       " break at word boundries for wrapped text
set noshowcmd                       " don't display partial commands (g,c etc.)
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
set novisualbell                    " turn off error beep/flash
set lazyredraw                      " don't redraw screen for macros

" indenting/formating
set autoindent                      " indent even if we have no filetype rules
" set smartindent                     " be smarter
set copyindent                      " copy indent chars from previous line
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

" edit current buffer in a new tab
nnoremap <silent><leader>z :tabedit!%<cr>
" move between tabs
" nnoremap <silent> <C-n> :tabn<cr>
" nnoremap <silent> <C-p> :tabp<cr>

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

if has('nvim')
  " remap esc in terminal mode
  tnoremap <Esc> <C-\><C-n>

  " navigate from terminal buffers
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l

  " navigate tab pages with A-<number>
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

augroup vimrc_filetype
  autocmd!

  " vim
  " save and source current file
  autocmd FileType vim nnoremap <buffer> <leader>so :w \| so%<cr>

  if has('nvim')
    " make autoread behave as expected (neovim only)
    autocmd FocusGained * if &autoread | silent checktime | endif
    " save last terminal job id
    autocmd TermOpen * let g:last_terminal_job_id = b:terminal_job_id
  endif

  " c/cpp
  autocmd BufEnter,BufReadPre,BufNewFile *.h,*.c setlocal filetype=c.doxygen

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

  autocmd FileType javascript,typescript, setlocal ts=2 sts=2 sw=2
  autocmd FileType css,less,scss,sass setlocal ts=2 sts=2 sw=2

  " hack to make development servers not rebuild twice
  autocmd FileType javascript setlocal nowritebackup

  " python
  " ------
  autocmd FileType python setlocal ts=4 sts=4 sw=4
  autocmd FileType cmake setlocal commentstring=#%s
augroup END

" }}}
" ==============================================================================
" PLUGIN CONFIGURATION
" ==============================================================================
" {{{

" ------------------------------------------------------------------------------
" -- Mundo  --------------------------------------------------------------------

nnoremap <F4> :MundoToggle<CR>

" ------------------------------------------------------------------------------
" -- UltiSnips  ----------------------------------------------------------------

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

nnoremap <leader>fs :Gstatus<cr>
nnoremap <F5> :Gblame<cr>

augroup vimrc_git
  autocmd!
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
nnoremap <silent> <leader>g/ :<C-u>Rg<cr>
" search in current buffer
nnoremap <silent> <leader>/ :<C-u>BLines<cr>
" search for current word in pwd
nnoremap <silent> <leader>i :<C-u>call SearchWordWithAg()<cr>
xnoremap <silent> <leader>i :<C-u>call SearchVisualSelectionWithAg()<cr>

function! SearchWordWithAg()
  execute 'Rg' expand('<cword>')
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
  execute 'Rg' selection
endfunction

" ------------------------------------------------------------------------------
" -- deoplete ------------------------------------------------------------------

if has('nvim')
  " Enable deoplete on InsertEnter
  let g:deoplete#enable_at_startup = 0
  autocmd vimrc InsertEnter * call deoplete#enable()

  call deoplete#custom#option({
  \ 'auto_complete_delay': 0,
  \ 'smart_case': v:true,
  \ 'camel_case': v:true,
  \ 'refresh_always': v:false,
  \ })

  " call deoplete#custom#option('sources', {
  "       \ 'supercollider': ['buffer', 'tag'],
  "       \})

  inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr><C-h> deoplete#smart_close_popup() . "\<C-h>"
  inoremap <expr><BS>  deoplete#smart_close_popup() . "\<C-h>"

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

let g:ale_set_signs = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_delay = 0
let g:ale_completion_enabled = 0
let g:ale_c_parse_compile_commands = 1

hi link ALEErrorLine ErrorMsg
hi link ALEWarningLine WarningMsg

let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'c': ['clang'],
      \ 'c.doxygen': ['clang'],
      \ 'cpp': ['clang']
      \ }

let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \ 'json': ['jq']
      \ }

let g:ale_c_clang_options = '-std=c99 -Iinclude -I../include -Wall -Wextra -pedantic'
let g:ale_c_parse_compile_commands = 1

" ------------------------------------------------------------------------------
" -- easy-align ----------------------------------------------------------------

" visual mode
vmap <leader>= <Plug>(EasyAlign)
" motions
nmap <leader>= <Plug>(EasyAlign)

" ------------------------------------------------------------------------------
" -- scnvim --------------------------------------------------------------------

" let g:scnvim_sclang_executable = '~/bin/sclang'
let g:scnvim_scdoc = 1
let g:scnvim_arghints_float = 1
let g:scnvim_echo_args = 1
" let g:scnvim_postwin_size = 25
" let g:scnvim_postwin_fixed_size = 25
" let g:scnvim_postwin_orientation = 'h'

nnoremap <leader>st :SCNvimStart<cr>
nnoremap <leader>sk :SCNvimRecompile<cr>

" snippet support
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'scnvim-data']

" create a custom status line for supercollider buffers
function! s:set_sclang_stl()
  setlocal stl=
  setlocal stl+=%f
  setlocal stl+=%=
  setlocal stl+=%(%l,%c%)
  setlocal stl+=\ \|
  setlocal stl+=%24.24{scnvim#statusline#server_status()}
endfunction

augroup scnvim_stl
  autocmd!
  autocmd FileType supercollider call <SID>set_sclang_stl()
augroup END

" ------------------------------------------------------------------------------
" -- misc ----------------------------------------------------------------------

" dont' conceal text in markdown files
let g:vim_markdown_conceal = 0

" unimpaired original mapping
nmap co yo

" seamless tmux navigation
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>

" file switching based on tags
function! s:switch_tag() abort
  let name = expand('%:t:r')
  let ext = expand('%:e')
  if ext ==# 'h'
    let dest = name . '.c'
  else
    let dest = name . '.h'
  endif
  try
    execute 'tag ' . dest
  catch
    echoerr printf('tag %s not found', name)
  endtry
endfunction

nnoremap <silent> <Leader>a :call <SID>switch_tag()<cr>

let g:pear_tree_repeatable_expand = 0

let $FZF_DEFAULT_OPTS='--layout=reverse --color=bw'
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

"##############################################################################
" Terminal Handling
"##############################################################################

function! ToggleScratchTerm()
    call ToggleTerm('zsh')
    startinsert
endfunction

nnoremap <leader>o :call ToggleScratchTerm()<cr>

function! ToggleTerm(cmd)
    if empty(bufname(a:cmd))
        call CreateCenteredFloatingWindow()
        call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
    else
        call DeleteUnlistedBuffers()
    endif
endfunction

function! OnTermExit(job_id, code, event) dict
    if a:code == 0
        call DeleteUnlistedBuffers()
    endif
endfunction

function! DeleteUnlistedBuffers()
    for n in nvim_list_bufs()
        if ! buflisted(n)
            let name = bufname(n)
            if name ==# '[Scratch]' ||
              \ matchend(name, ':fzf') ||
              \ matchend(name, ':zsh')
                call CleanupBuffer(n)
            endif
        endif
    endfor
endfunction

function! CleanupBuffer(buf)
    if bufexists(a:buf)
        silent execute 'bwipeout! '.a:buf
    endif
endfunction

" Creates a floating window with a most recent buffer to be used
function! CreateCenteredFloatingWindow()
    let width = float2nr(&columns * 0.6)
    let height = float2nr(&lines * 0.6)
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    autocmd BufWipeout <buffer> call CleanupBuffer(s:buf)
    tnoremap <buffer> <silent> <Esc> <C-\><C-n><CR>:call DeleteUnlistedBuffers()<CR>
endfunction

"" clangd LSP
lua << EOF
local nvim_lsp = require'nvim_lsp'
nvim_lsp.clangd.setup{
  cmd = {"/usr/local/Cellar/llvm/9.0.0_1/bin/clangd", "--background-index"};
  filetypes = {"c", "cpp"};
}
EOF

function! EchoHighlightGroup()
  for id in synstack(line("."), col("."))
    echo synIDattr(id, "name")
  endfor
endfunction

" ===========================================================================
" }}}

" vim:foldmethod=marker colorcolumn=80 textwidth=80
