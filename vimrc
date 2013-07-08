"
" vimrc
"
" ============================================================================
" PLUGINS
" ============================================================================
" {{{

" no need to be compatible with vi
set nocompatible

" make NeoBundle to manage all plugins
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" source local plugins (not managed by NeoBundle)
NeoBundleLocal ~/.vim/bundle

" let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" -- Plugins  ----------------------------------------------------------------

NeoBundle 'Shougo/unite.vim',         { 'name' : 'unite'                     }
NeoBundle 'Shougo/unite-outline',     { 'name' : 'outline'                   }
NeoBundle 'ujihisa/unite-colorscheme',{ 'name' : 'unite-colorscheme'         }
NeoBundle 'tpope/vim-commentary' ,    { 'name' : 'commentary'                }
NeoBundle 'tpope/vim-surround' ,      { 'name' : 'surround'                  }
NeoBundle 'tpope/vim-repeat' ,        { 'name' : 'repeat'                    }
NeoBundle 'godlygeek/tabular',        { 'name' : 'tabular'                   }
NeoBundle 'Raimondi/delimitMate',     { 'name' : 'delimitMate'               }
NeoBundle 'scrooloose/nerdtree',      { 'name' : 'nerdtree'                  }
NeoBundle 'ervandew/supertab',        { 'name' : 'supertab'                  }
NeoBundle 'SirVer/ultisnips',         { 'name' : 'ultisnips'                 }
NeoBundle 'davidgranstrom/scvim',     { 'name' : 'supercollider'             }
NeoBundle 'bling/vim-airline',        { 'name' : 'airline'                   }
NeoBundle 'sjl/badwolf',              { 'name' : 'badwolf'                   }
NeoBundle 'vim-scripts/Colour-Sampler-Pack',{ 'name' : 'colour-sampler-pack' }

" automated builds
NeoBundle 'Shougo/vimproc', {
        \ 'name'  : 'vimproc',
        \ 'build' : {
        \     'windows' : 'make -f make_mingw32.mak',
        \     'cygwin' : 'make -f make_cygwin.mak',
        \     'mac' : 'make -f make_mac.mak',
        \     'unix' : 'make -f make_unix.mak',
        \    },
        \ }

" lazy bundles (sourced only when needed)
NeoBundleLazy 'sophacles/vim-processing', {
            \ 'name' : 'processing',
            \ 'autoload' : { 'filetypes' : 'processing' }
            \}
NeoBundleLazy 'godlygeek/csapprox', {
            \ 'name' : 'csapprox',
            \ 'augroup' : 'CSApprox',
            \ 'terminal' : 1
            \}
NeoBundleLazy 'sjl/gundo.vim', {
            \ 'name' : 'gundo',
            \ 'autoload' : { 'commands' : ':GundoToggle' }
            \}
NeoBundleLazy 'majutsushi/tagbar', {
            \ 'name' : 'tagbar',
            \ 'autoload' : { 'commands' : ':TagbarToggle' }
            \}
NeoBundleLazy 'tpope/vim-fugitive', {
            \ 'name' : 'fugitive',
            \ 'augroup' : 'fugitive',
            \ 'autoload' : { 'commands' : ':Gstatus' }
            \}
NeoBundleLazy 'b4winckler/vim-objc', {
            \ 'name' : 'objc',
            \ 'autoload' : { 'filetypes' : 'objc' }
            \}
NeoBundleLazy 'Rip-Rip/clang_complete', {
            \ 'name' : 'clang_complete',
            \ 'autoload' : { 'filetypes' : 'c,cpp,objc' }
            \}
NeoBundleLazy 'derekwyatt/vim-fswitch', {
            \ 'name' : 'fswitch',
            \ 'autoload' : { 'filetypes' : 'c,cpp,objc' }
            \}


" pending
"
" NeoBundle 'vim-scripts/ScrollColors', { 'name' : 'scrollcolors' }
" NeoBundle 'Lokaltog/powerline',       { 'name' :  'powerline'   }

" disabled
NeoBundleDisable unite-colorscheme

" ----------------------------------------------------------------------------
" }}}
" ============================================================================
" GLOBAL
" ============================================================================
" {{{

filetype plugin indent on         " detect plugin filetypes
syntax enable                     " syntax highlighting

NeoBundleCheck                    " installation check
                                  " call on_source hook when reloading .vimrc
if !has('vim_starting')
    call neobundle#call_hook('on_source')
endif

set directory^=$HOME/.vim/.swap// " put all swap files in one place
let mapleader=","                 " set mapleader
set mouse=a                       " enable mouse
set clipboard=unnamed             " yank to system-wide clipboard
set timeout timeoutlen=600        " shorter timeout lenght for keystrokes
set ttyfast                       " assume fast terminal
set hidden                        " be able to hide modified buffers
set nowrap                        " don't wrap words
set nostartofline                 " keep the cursor at the current column when moving
set scrolloff=8                   " keep a distance of from the cursor when scrolling
set formatoptions+=r              " auto insert comments from insert mode
set ignorecase                    " ignore case in search patterns
set smartcase                     " overrides 'ignorecase' if search pattern contains an upper char
set incsearch                     " incrementally match the search
set wildmenu                      " enhanced command line completion
set wildignorecase                " be smart case-sensitive
set backspace=2                   " allow backspacing over indent, eol, and the start of an insert
set virtualedit=all               " be able to access all areas of the buffer
" set complete+=k                   " where to look for auto-completion
set complete-=i
set diffopt+=vertical             " use vertical diffs by default
set laststatus=2                  " always display a status line
" turn off all alerts
set visualbell                    " turn off error beep/flash
" set visualbell t_vb=              " turn off error beep/flash
set autochdir                     " change to cwd of current file
set fillchars=

" indenting
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround

"status line
" set statusline=%<%f\ [buf:%n]\ %h%m%r%=ln:%l\ col:%c%V\ \|\ char:%b\ [\ %p%%\ ]
" custom list chars
set listchars=eol:$,tab:>-,trail:-,nbsp:%

" colorscheme
if has("gui_running")
    " set colorscheme and fonts
    colorscheme kellys
    set guifont=Monospace,Menlo:h12
    set guicursor=n-c-v:block-Cursor-blinkOn0
    "get rid of the toolbar/scrollbars
    set guioptions-=T
    set go-=r
    set go-=L
    "use console dialogs for simple choices
    set go+=c
else
    set t_Co=256
    colorscheme rootwater-cterm
endif

" use par to format text
if executable("par")
    set formatprg=par\ -w78gqr
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" automatic git commits when editing the wiki
function! GitCommitBuffer()
    let path = expand("%:p")
    let name = expand("%:t")
    exec '!git commit ' . path . ' -m "Update: ' . name . '"'
endfunction
augroup wiki
    au!
    au BufEnter     $HOME/dkg-wiki/*.md set autochdir
    au BufWritePre  $HOME/dkg-wiki/*.md call DeleteTrailingWS()
    au BufWritePost $HOME/dkg-wiki/*.md call GitCommitBuffer()
augroup END

" }}}
" ============================================================================
" KEY MAPPINGS
" ============================================================================
" {{{

" edit vimrc
nnoremap <leader>ev :tabe $MYVIMRC<CR>

" save and source current file
nnoremap <silent> <leader>so :w<CR>:so%<CR>
    \:echo "Saved and sourced current buffer.."<CR>

" move to tags in help files
noremap <silent> å <C-]>

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

" change to the dir of the current file
noremap <F7> :cd %:p:h<CR>:pwd<CR>

" make horizontal scrolling easier
nnoremap <C-l> 10zl
nnoremap <C-h> 10zh

" toggle fold column
let g:setfoldcolumn= 0
function! ToggleFoldColumn()
    if g:setfoldcolumn==0
        let g:setfoldcolumn= 1
        set foldcolumn=4
    else
        let g:setfoldcolumn= 0
        set foldcolumn=0
    endif
endfunction
nnoremap <silent> <Leader>tf :call ToggleFoldColumn()<CR>

" Show syntax highlighting groups for word under cursor
" function! <SID>SynStack()
"   if !exists("*synstack")
"     return
"   endif
"   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunc
" nmap <Leader><F12> :call <SID>SynStack()<CR>

" delete trailing whitespace in the whole buffer
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" insert current date
" iab <expr> dts strftime("%d/%m/%Y")

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

" put/delete spaces between list items
" let g:putSpace = 0
" function! FormatList()
"     " let curline = getline(".")
"     " substitute(curline, ",", ", ", "g")
"     " let curLine = getline(".")
"     if g:putSpace==0
"         exec "normal! :s/,/, /g<CR>"
"         let g:putSpace = 1
"     else
"         " substitute(curLine, ",\s\+", ",", "g")
"         exec "normal! :s/,\s\+/,/g<CR>"
"         let g:putSpace = 0
"     endif
" endfunction
" nnoremap <leader><Space> call FormatList()<CR>

" split a comma delimited list (inverse of 'normal J')
" nnoremap <leader>J :SplitCommaList<CR>

" create an empty buffer for SuperCollider code
" nnoremap <leader>sn :SCNewScratchBuf<CR>

" use <esc> to cancel completion
inoremap <expr> <Esc> pumvisible() ? "\<C-y>" : "\<Esc>"
inoremap <expr> <C-c> pumvisible() ? "\<C-e>" : "\<C-c>"
" already set with delimitMate plugin
" inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<CR>"

" edit current buffer in a new tab (buffer must be saved first)
nnoremap <silent><leader>te :tabedit %<CR>
nnoremap <silent><leader>tl :tabmove +1<CR>
nnoremap <silent><leader>th :tabmove -1<CR>
if has("gui_macvim")
    nnoremap <D-1> 1gt
    nnoremap <D-2> 2gt
    nnoremap <D-3> 3gt
    nnoremap <D-4> 4gt
    nnoremap <D-5> 5gt
    nnoremap <D-Left>  :tabmove -1<CR>
    nnoremap <D-Right> :tabmove +1<CR>
endif

" }}}
" ============================================================================
" LANGUAGE SETTINGS
" ============================================================================
" {{{

" source supercollider mappings
so ~/.vim/bundle/dkg/supercollider/scvim_init.vim

" markdown
au! BufEnter,BufWinEnter,BufNewFile,BufRead *.md,*.markdown set filetype=markdown

" supercollider
" au! BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set filetype=supercollider
" au! FileType supercollider NeoBundleSource supercollider

" processing
" au! BufEnter,BufWinEnter,BufNewFile,BufRead *.pde set filetype=processing
" au! FileType processing NeoBundleSource processing

" }}}
" ============================================================================
" PLUGIN MAPPINGS
" ============================================================================
" {{{

" -- NerdTREE  ---------------------------------------------------------------

" toggle
map <silent> <F2> :NERDTreeToggle ~/<CR>
map <silent> <F3> :NERDTreeFind<CR>

" ----------------------------------------------------------------------------
" -- Unite  ------------------------------------------------------------------

" let g:unite_split_rule = 'botright'
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])

nnoremap <leader>t :<C-u>Unite -start-insert file_rec/async<cr>
nnoremap <leader>r :<C-u>Unite -start-insert file_rec/async:!<cr>
nnoremap <leader>b :<C-u>Unite -start-insert -no-split buffer<cr>
nnoremap <leader>f :<C-u>Unite -no-split file<cr>

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


" neocomplete
" Use neocomplete.
" let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
" let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" " Define dictionary.
" let g:neocomplete#sources#dictionary#dictionaries = {
"             \ 'default' : '',
"             \ 'vimshell' : $HOME.'/.vimshell_hist',
"             \ 'supercollider' : $HOME.'/.scvim/sc_object_completion',
"             \ }
" let g:neocomplete#use_vimproc = 1
" let l:source = {
"             \ 'name' : 'scvim',
"             \ 'kind' : 'manual',
"             \ 'filetypes' : { 'supercollider' : 1 },
"             \}

" ----------------------------------------------------------------------------
" -- SuperTab  ---------------------------------------------------------------

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabCrMapping = 0

" ----------------------------------------------------------------------------
" -- Gundo  ------------------------------------------------------------------

nnoremap <F4> :GundoToggle<CR>

" ----------------------------------------------------------------------------
" -- Tabularize  -------------------------------------------------------------

" align '='
vnoremap <silent> + :Tabularize/=<CR>
" align events
vnoremap <silent> <CR> :Tabularize/\\\w\+,\zs\s<CR>

" ----------------------------------------------------------------------------
" -- UltiSnips  --------------------------------------------------------------

let g:UltiSnipsListSnippets = "<c-\\>"
let g:UltiSnips_Author = "David Granstrom"
let g:UltiSnipsExpandTrigger       = "<Tab>"
let g:UltiSnipsJumpForwardTrigger  = "<C-l>"
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

" ----------------------------------------------------------------------------
" -- Tagbar  -----------------------------------------------------------------

let g:tagbar_autofocus = 1
let g:tagbar_width     = 35
" let g:tagbar_compact   = 1
nnoremap <silent> <F5> :TagbarToggle<CR>

" SuperCollider syntax
let g:tagbar_type_supercollider = {
    \ 'ctagstype' : 'supercollider',
    \ 'kinds'     : [
        \ 'c:Class names',
        \ 'm:Class methods',
        \ 'i:Instance methods',
    \ ],
    \ 'sort' : 0
\ }

" add this later to get full functionality (needs parser)
    " \ 'sort' : 0,
    " \ 'sro'  : '.',
    " \ 'kind2scope' : {
    "     \ 'c' : 'Class names',
    "     \ 'm' : 'Class methods',
    "     \ 'i' : 'Instance methods',
    " \ },
    " \ 'scope2kind' : {
    "     \ 'Class names'      : 'c',
    "     \ 'Class methods'    : 'm',
    "     \ 'Instance methods' : 'i',
    " \ }

" ----------------------------------------------------------------------------
" -- delimitMate  ------------------------------------------------------------

imap <C-j> <Plug>delimitMateS-Tab
imap <expr> <CR> pumvisible() ?
    \"\<c-y>" :
    \ "<Plug>delimitMateCR"
let delimitMate_expand_cr    = 1
let delimitMate_expand_space = 1

" ----------------------------------------------------------------------------
" ========================================================================={{{

" vim:foldmethod=marker
