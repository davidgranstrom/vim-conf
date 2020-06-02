"
" init.vim
"
" ==============================================================================
" PLUGINS
" ==============================================================================
" {{{

" vim-plug
call plug#begin(stdpath('config') . '/bundle')

" editing
Plug 'Shougo/deoplete.nvim'
Plug 'deoplete-plugins/deoplete-tag'
Plug 'SirVer/ultisnips'
Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'justinmk/vim-dirvish'

" util
Plug 'w0rp/ale', { 'on': 'ALEToggleBuffer' }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
if has('nvim-0.5')
Plug 'neovim/nvim-lsp'
end
Plug 'tpope/vim-fugitive'
Plug 'norcalli/nvim-colorizer.lua'

" language
Plug 'sheerun/vim-polyglot'
" Plug '~/code/vim/scnvim'
Plug 'davidgranstrom/scnvim', { 'branch': 'topic/install-scripts', 'do': './bin/install_mac.sh' }

" color schemes / appearance
Plug 'andreypopp/vim-colors-plain'
Plug 'noahfrederick/vim-noctu'
Plug 'wadackel/vim-dogrun'

" misc
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-apathy'
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

" editing
set virtualedit=all      " be able to access all areas of the buffer
set hidden               " be able to hide modified buffers
set clipboard=unnamed    " yank to system-wide clipboard
set completeopt-=preview " don't display scratch buffer for completion
set inccommand=nosplit   " preview changes (:s/) incrementally

" appearance
set termguicolors
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

colorscheme dogrun

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

  " vim
  " save and source current file
  autocmd FileType vim nnoremap <buffer> <leader>so :w \| so%<cr>

  " if has('nvim')
  "   " make autoread behave as expected (neovim only)
  "   autocmd FocusGained * if &autoread | silent checktime | endif
  "   " save last terminal job id
  "   autocmd TermOpen * let g:last_terminal_job_id = b:terminal_job_id
  " endif

  " c/cpp
  " autocmd BufEnter,BufReadPre,BufNewFile *.h,*.c setlocal filetype=c.doxygen

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
" PLUGIN CONFIGURATION
" ==============================================================================
" {{{

" ------------------------------------------------------------------------------
" -- UltiSnips  ----------------------------------------------------------------

let g:UltiSnips_Author = "David Granström"
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsUsePythonVersion = 3

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
nnoremap <silent> <leader>t :<C-u>GFiles<cr>
" select buffers
nnoremap <silent> <leader>b :<C-u>Buffers<cr>
" search in current dir
nnoremap <silent> <leader>g/ :<C-u>Rg<cr>
" search for current word in pwd
nnoremap <silent> <leader>i :<C-u>call <sid>search_word()<cr>
xnoremap <silent> <leader>i :<C-u>call <sid>search_selection()<cr>

function! s:search_word()
  execute 'Rg' expand('<cword>')
endfunction

function! s:search_selection() range
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

let $FZF_DEFAULT_OPTS='--layout=reverse --color=bw'
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

" ------------------------------------------------------------------------------
" -- deoplete ------------------------------------------------------------------

" Don't enable until InsertEnter
let g:deoplete#enable_at_startup = 0
autocmd vimrc InsertEnter * call deoplete#enable()

call deoplete#custom#option({
      \ 'auto_complete_delay': 0,
      \ 'smart_case': v:true,
      \ 'camel_case': v:true,
      \ 'refresh_always': v:false,
      \ })

inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><C-h> deoplete#smart_close_popup() . "\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup() . "\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction

" ------------------------------------------------------------------------------
" -- Ale -----------------------------------------------------------------------

let g:ale_set_signs = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_delay = 0
let g:ale_completion_enabled = 0
let g:ale_c_parse_compile_commands = 1
let g:ale_c_clang_options = '-std=c99 -Iinclude -I../include -Wall -Wextra -pedantic'

hi link ALEErrorLine ErrorMsg
hi link ALEWarningLine WarningMsg

let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'c': ['clang'],
      \ 'c.doxygen': ['clang'],
      \ 'cpp': ['clang'],
      \ 'json': ['jq'],
      \ 'vim': ['vint --enable-neovim']
      \ }

let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \ 'json': ['jq']
      \ }

nmap <leader>l <Plug>(ale_toggle_buffer)

" ------------------------------------------------------------------------------
" -- scnvim --------------------------------------------------------------------

let g:scnvim_scdoc = 1
let g:scnvim_arghints_float = 1
let g:scnvim_echo_args = 1
" let g:scnvim_postwin_layout = {
"   \ 'style': 'float',
"   \ 'style': 'inline', " default
"   \ 'bufnum': function('create#buf'),  " optional
" }

nnoremap <leader>st :SCNvimStart<cr>
nnoremap <leader>sk :SCNvimRecompile<cr>

" snippet support
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'scnvim-data']

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

" clangd LSP
if has('nvim-0.5')
lua << EOF
local nvim_lsp = require'nvim_lsp'
nvim_lsp.clangd.setup{
cmd = {"/usr/local/Cellar/llvm/9.0.0_1/bin/clangd", "--background-index"};
filetypes = {"c", "cpp"};
}
vim.lsp.callbacks['textDocument/publishDiagnostics'] = function() end
EOF
end

function! EchoHighlightGroup()
  for id in synstack(line("."), col("."))
    echo synIDattr(id, "name")
  endfor
endfunction

" https://github.com/justinmk/config/blob/master/.config/nvim/init.vim
function! s:hl_yank(operator, regtype, inclusive) abort
  if a:operator !=# 'y' || a:regtype ==# ''
    return
  endif
  " edge cases:
  "   ^v[count]l ranges multiple lines

  " TODO:
  "   bug: ^v where the cursor cannot go past EOL, so '] reports a lesser column.

  let bnr = bufnr('%')
  let ns = nvim_create_namespace('')
  call nvim_buf_clear_namespace(bnr, ns, 0, -1)

  let [_, lin1, col1, off1] = getpos("'[")
  let [lin1, col1] = [lin1 - 1, col1 - 1]
  let [_, lin2, col2, off2] = getpos("']")
  let [lin2, col2] = [lin2 - 1, col2 - (a:inclusive ? 0 : 1)]
  for l in range(lin1, lin1 + (lin2 - lin1))
    let is_first = (l == lin1)
    let is_last = (l == lin2)
    let c1 = is_first || a:regtype[0] ==# "\<C-v>" ? (col1 + off1) : 0
    let c2 = is_last || a:regtype[0] ==# "\<C-v>" ? (col2 + off2) : -1
    call nvim_buf_add_highlight(bnr, ns, 'TextYank', l, c1, c2)
  endfor
  call timer_start(100, {-> nvim_buf_is_valid(bnr) && nvim_buf_clear_namespace(bnr, ns, 0, -1)})
endfunc

highlight default link TextYank Search

augroup hlyank
  autocmd!
  autocmd TextYankPost * call s:hl_yank(v:event.operator, v:event.regtype, v:event.inclusive)
augroup END

" ===========================================================================
" }}}

" vim:foldmethod=marker colorcolumn=80 textwidth=80
