set background=dark
hi! clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "obsidian"
" lua require('lush')(require('lush_theme/obsidian'))

"Theme built with Lush.nvim, exported at Thu Dec  3 23:15:33 2020
highlight LineNr guifg=#003333 guibg=NONE guisp=NONE gui=NONE
highlight Pmenu guifg=#D9D9D9 guibg=#333333 guisp=NONE gui=NONE
highlight PmenuSel guifg=NONE guibg=#007F80 guisp=NONE gui=NONE
highlight Error guifg=#FF00FF guibg=NONE guisp=NONE gui=NONE
highlight VertSplit guifg=#6E6E6E guibg=NONE guisp=NONE gui=NONE
highlight StorageClass guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight Typedef guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight Define guifg=#007F80 guibg=NONE guisp=NONE gui=NONE
highlight MsgArea guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight! link TabLine StatusLine
highlight Directory guifg=#007F80 guibg=NONE guisp=NONE gui=NONE
highlight TermCursorNC guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight MatchParen guifg=NONE guibg=#FF00FF guisp=NONE gui=NONE
highlight EndOfBuffer guifg=#2B2B2B guibg=#000000 guisp=NONE gui=NONE
highlight Identifier guifg=#00C2C2 guibg=NONE guisp=NONE gui=NONE
highlight! link LspDiagnosticsErrorSign Error
highlight Question guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight Operator guifg=#00C2C2 guibg=NONE guisp=NONE gui=NONE
highlight ModeMsg guifg=#FF00FF guibg=NONE guisp=NONE gui=NONE
highlight Cursor guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight TabLineSel guifg=NONE guibg=#007F80 guisp=NONE gui=NONE
highlight! link IncSearch Search
highlight WarningMsg guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight! link CursorColumn CursorLine
highlight TSType guifg=#ffffff guibg=NONE guisp=NONE gui=NONE
highlight DiffDelete guifg=NONE guibg=#FF00FF guisp=NONE gui=NONE
highlight StatusLine guifg=#D9D9D9 guibg=#080808 guisp=NONE gui=NONE
highlight Conceal guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight NormalNC guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight Visual guifg=#D9D9D9 guibg=#007F80 guisp=NONE gui=NONE
highlight Tag guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight! link TabLineFill StatusLine
highlight ErrorMsg guifg=#FF00FF guibg=NONE guisp=NONE gui=NONE
highlight MsgSeparator guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight TermCursor guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight SignColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight! link TSCharacter Character
highlight Keyword guifg=#00C2C2 guibg=NONE guisp=NONE gui=NONE
highlight Statement guifg=#007F80 guibg=NONE guisp=NONE gui=NONE
highlight PreCondit guifg=#007F80 guibg=NONE guisp=NONE gui=NONE
highlight Title guifg=#007F80 guibg=NONE guisp=NONE gui=NONE
highlight WildMenu guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight DiffText guifg=#FF00FF guibg=NONE guisp=NONE gui=NONE
highlight Comment guifg=#4D4D4D guibg=#000000 guisp=NONE gui=NONE
highlight Normal guifg=#D9D9D9 guibg=#000000 guisp=NONE gui=NONE
highlight PmenuSbar guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight Type guifg=#00C2C2 guibg=NONE guisp=NONE gui=NONE
highlight CursorIM guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight Special guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight Search guifg=#D9D9D9 guibg=#007F80 guisp=NONE gui=NONE
highlight! link LspDiagnosticsErrorFloating Error
highlight! link LspDiagnosticsError Error
highlight! link Float Number
highlight Todo guifg=#D9D9D9 guibg=#80007F guisp=NONE gui=NONE
highlight Debug guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight SpecialComment guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight Function guifg=#007F80 guibg=NONE guisp=NONE gui=NONE
highlight StatusLineNC guifg=#424242 guibg=#080808 guisp=NONE gui=NONE
highlight Structure guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight SpecialChar guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight! link TSString String
highlight Repeat guifg=#00C2C2 guibg=NONE guisp=NONE gui=NONE
highlight PmenuThumb guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight Character guifg=#FF00FF guibg=NONE guisp=NONE gui=NONE
highlight Delimiter guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight Macro guifg=#007F80 guibg=NONE guisp=NONE gui=NONE
highlight Include guifg=#007F80 guibg=NONE guisp=NONE gui=NONE
highlight Conditional guifg=#00C2C2 guibg=NONE guisp=NONE gui=NONE
highlight Boolean guifg=#FF00FF guibg=NONE guisp=NONE gui=NONE
highlight DiffChange guifg=NONE guibg=#00C2C2 guisp=NONE gui=NONE
highlight NormalFloat guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight MoreMsg guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight String guifg=#A142FF guibg=NONE guisp=NONE gui=NONE
highlight Folded guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight SpellRare guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight lCursor guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight SpecialKey guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight ColorColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight Substitute guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight FoldColumn guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight DiffAdd guifg=NONE guibg=#007F80 guisp=NONE gui=NONE
highlight CursorLine guifg=#C4C4C4 guibg=#1A1A1A guisp=NONE gui=NONE
highlight NonText guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight Constant guifg=#007F80 guibg=NONE guisp=NONE gui=NONE
highlight QuickFixLine guifg=NONE guibg=NONE guisp=NONE gui=NONE
highlight Label guifg=#00C2C2 guibg=NONE guisp=NONE gui=NONE
highlight CursorLineNr guifg=#42FFFF guibg=#000000 guisp=NONE gui=NONE
highlight Number guifg=#D9D9D9 guibg=NONE guisp=NONE gui=NONE
highlight Exception guifg=#007F80 guibg=NONE guisp=NONE gui=NONE
highlight PreProc guifg=#007F80 guibg=NONE guisp=NONE gui=NONE
