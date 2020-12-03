--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--
-- This is the Lush tutorial. It demostrates the functionality of Lush and how
-- to write a basic lush-spec. For more information, see the README.
--
-- A Lush theme starter template can be found in the examples folder.
--

-- First, enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`
--
-- (try putting your cursor inside the ` and typing yi`:@"<CR>)
--
-- Calls to hsl() are now highlighted with the correct background colour
-- Highlight names groups will have the highlight style applied to them.

-- Lets get started, first we have to require lush, and optionally bind
-- hsl to a more usable name. HSL can also be imported into other modules.

local lush = require('lush')
local hsl = lush.hsl

-- HSL stands for Hue        (0 - 360)
--                Saturation (0 - 100)
--                Lightness  (0 - 100)
--
-- By working with HSL, it's easy to define relationships between colours.
--
-- For example, rotating a hue between 30 and 60 degrees will find harmonious
-- colours, or 180 degrees will find it's complementary colour. Colour theory
-- is beyond the scope of this document, but with the examples below it
-- should start to make some sense.
--
-- Lets define some colors (these should already be highlighted for you):

local obsidian  = hsl(0, 0, 0).lighten(0)  -- the integers used here.
local white  = hsl('#ffffff').darken(15)  -- Try presing C-a and C-x
local magenta  = hsl('#ff00ff').darken(10)  -- Try presing C-a and C-x
local cyan  = hsl('#00ffff').darken(50)  -- Try presing C-a and C-x
local DefaultHl = { fg = white, bg = obsidian }

local theme = lush(function()
  return {
    Normal { bg = obsidian, fg = white }, -- normal text
    CursorLine { bg = Normal.bg.lighten(10), fg = Normal.fg.darken(10)  }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    Visual { bg = cyan, fg = Normal.fg.rotate(180) },
    CursorColumn { CursorLine }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    -- Whitespace { fg = Normal.bg.desaturate(25).lighten(25) },
    Comment { bg = Normal.bg, fg = Normal.bg.lighten(30) },
    LineNr       { fg = cyan.darken(60) }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr { bg = Normal.bg, fg = cyan.lighten(50) }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.

    Search       { fg = white, bg = cyan },
    IncSearch    { Search },

    NormalFloat  { DefaultHl }, -- Normal text in floating windows.
    ColorColumn  { DefaultHl }, -- used for the columns set with 'colorcolumn'
    Conceal      { DefaultHl }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor       { DefaultHl }, -- character under the cursor
    lCursor      { DefaultHl }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM     { DefaultHl }, -- like Cursor, but used when in IME mode |CursorIM|
    Directory    { fg = cyan }, -- directory names (and other special names in listings)
    DiffAdd      { bg = cyan }, -- diff mode: Added line |diff.txt|
    DiffChange   { DefaultHl }, -- diff mode: Changed line |diff.txt|
    DiffDelete   { bg = magenta }, -- diff mode: Deleted line |diff.txt|
    DiffText     { DefaultHl }, -- diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer  { fg = Normal.fg.darken(80), bg = Normal.bg }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    TermCursor   { DefaultHl }, -- cursor in a focused terminal
    TermCursorNC { DefaultHl }, -- cursor in an unfocused terminal
    ErrorMsg     { fg = magenta }, -- error messages on the command line
    VertSplit    { fg = white.darken(30) }, -- the column separating vertically split windows
    Folded       { DefaultHl }, -- line used for closed folds
    FoldColumn   { DefaultHl }, -- 'foldcolumn'
    SignColumn   { DefaultHl }, -- column where |signs| are displayed
    Substitute   { DefaultHl }, -- |:substitute| replacement text highlighting
    MatchParen   { bg = magenta }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg      { fg = magenta }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea      { DefaultHl }, -- Area for messages and cmdline
    MsgSeparator { DefaultHl }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg      { DefaultHl }, -- |more-prompt|
    NonText      { DefaultHl }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    NormalNC     { DefaultHl }, -- normal text in non-current windows
    Pmenu        { bg = Normal.bg.lighten(20), fg = Normal.fg  }, -- Popup menu: normal item.
    PmenuSel     { bg = cyan  }, -- Popup menu: selected item.
    PmenuSbar    { DefaultHl  }, -- Popup menu: scrollbar.
    PmenuThumb   { DefaultHl  }, -- Popup menu: Thumb of the scrollbar.
    Question     { DefaultHl  }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine { DefaultHl  }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    SpecialKey   { DefaultHl  }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace| SpellBad  Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.  SpellCap  Word that should start with a capital. |spell| Combined with the highlighting used otherwise.  SpellLocal  Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare    { DefaultHl  }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine   { fg = Normal.fg, bg = Normal.bg.lighten(3) }, -- status line of current window
    StatusLineNC { fg = Normal.fg.darken(70), bg = Normal.bg.lighten(3) }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine      { StatusLine }, -- tab pages line, not active tab page label
    TabLineFill  { StatusLine }, -- tab pages line, where there are no labels
    TabLineSel   { bg = cyan  }, -- tab pages line, active tab page label
    Title        { fg = cyan  }, -- titles for output from ":set all", ":autocmd" etc.
    -- Visual       { DefaultHl  }, -- Visual mode selection
    -- VisualNOS    { DefaultHl  }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg   { DefaultHl  }, -- warning messages
    -- Whitespace   { DefaultHl  }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu     { DefaultHl  }, -- current match in 'wildmenu' completion

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    Constant       { fg = cyan },             -- (preferred) any constant
    -- String         { fg = cyan.lighten(50) }, --   a string constant: "this is a string"
    String         { fg = magenta.darken(20) }, --   a string constant: "this is a string"
    Character      { fg = String.fg.lighten(20) }, --  a character constant: 'c', '\n'
    Number         { fg = cyan.lighten(70) }, --   a number constant: 234, 0xff
    Float          { Number },                --    a floating point constant: 2.3e10
    Boolean        { fg = cyan.lighten(80) }, --  a boolean constant: TRUE, false

    Identifier     { fg = cyan.lighten(15) }, -- (preferred) any variable name
    Function       { fg = cyan.darken(20)  }, -- function name (also: methods for classes)

    Statement      { fg = cyan.lighten(80) }, -- (preferred) any statement
    Conditional    { fg = cyan.lighten(70) }, --  if, then, else, endif, switch, etc.
    Repeat         { fg = cyan.lighten(60) }, --   for, do, while, etc.
    Label          { fg = cyan.lighten(50) }, --    case, default, etc.
    Operator       { fg = cyan.lighten(40) }, -- "sizeof", "+", "*", etc.
    Keyword        { fg = cyan.lighten(30) }, --  any other keyword
    Exception      { fg = cyan.lighten(20) }, --  try, catch, throw

    PreProc        { fg = cyan.lighten(0)  }, -- (preferred) generic Preprocessor
    Include        { fg = cyan.lighten(10) }, --  preprocessor #include
    Define         { fg = cyan.lighten(20) }, --   preprocessor #define
    Macro          { fg = cyan.lighten(30) }, --    same as Define
    PreCondit      { fg = cyan.lighten(40) }, --  preprocessor #if, #else, #endif, etc.

    Type           { fg = cyan  },            -- (preferred) int, long, char, etc.
    StorageClass   { DefaultHl  },            -- static, register, volatile, etc.
    Structure      { DefaultHl  },            --  struct, union, enum, etc.
    Typedef        { DefaultHl  },            --  A typedef

    Special        { DefaultHl  },            -- (preferred) any special symbol
    SpecialChar    { DefaultHl  },            --  special character in a constant
    Tag            { DefaultHl  },            --    you can use CTRL-] on this
    Delimiter      { DefaultHl  },            --  character that needs attention
    SpecialComment { DefaultHl  },            -- special things inside a comment
    Debug          { DefaultHl  },            --    debugging statements

    -- Underlined { gui = "underline" }, -- (preferred) text that stands out, HTML links
    -- Bold       { gui = "bold" },
    -- Italic     { gui = "italic" },

    -- ("Ignore", below, may be invisible...)
    -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

    Error          { fg = magenta }, -- (preferred) any erroneous construct

    Todo           { fg = white, bg = magenta.darken(50) }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client. Some other LSP clients may use
    -- these groups, or use their own. Consult your LSP client's documentation.

    LspDiagnosticsError               { Error }, -- used for "Error" diagnostic virtual text
    LspDiagnosticsErrorSign           { Error }, -- used for "Error" diagnostic signs in sign column
    LspDiagnosticsErrorFloating       { Error }, -- used for "Error" diagnostic messages in the diagnostics float
    -- LspDiagnosticsWarning             { }, -- used for "Warning" diagnostic virtual text
    -- LspDiagnosticsWarningSign         { }, -- used for "Warning" diagnostic signs in sign column
    -- LspDiagnosticsWarningFloating     { }, -- used for "Warning" diagnostic messages in the diagnostics float
    -- LspDiagnosticsInformation         { }, -- used for "Information" diagnostic virtual text
    -- LspDiagnosticsInformationSign     { }, -- used for "Information" signs in sign column
    -- LspDiagnosticsInformationFloating { }, -- used for "Information" diagnostic messages in the diagnostics float
    -- LspDiagnosticsHint                { }, -- used for "Hint" diagnostic virtual text
    -- LspDiagnosticsHintSign            { }, -- used for "Hint" diagnostic signs in sign column
    -- LspDiagnosticsHintFloating        { }, -- used for "Hint" diagnostic messages in the diagnostics float
    -- LspReferenceText                  { }, -- used for highlighting "text" references
    -- LspReferenceRead                  { }, -- used for highlighting "read" references
    -- LspReferenceWrite                 { }, -- used for highlighting "write" references

    -- These groups are for the neovim tree-sitter highlights.
    -- As of writing, tree-sitter support is a WIP, group names may change.
    -- By default, most of these groups link to an appropriate Vim group,
    -- TSError -> Error for example, so you do not have to define these unless
    -- you explicitly want to support Treesitter's improved syntax awareness.

    -- TSError              { }, -- For syntax/parser errors.
    -- TSPunctDelimiter     { }, -- For delimiters ie: `.`
    -- TSPunctBracket       { }, -- For brackets and parens.
    -- TSPunctSpecial       { }, -- For special punctutation that does not fall in the catagories before.
    -- TSConstant           { }, -- For constants
    -- TSConstBuiltin       { }, -- For constant that are built in the language: `nil` in Lua.
    -- TSConstMacro         { }, -- For constants that are defined by macros: `NULL` in C.
    TSString             { String }, -- For strings.
    -- TSStringRegex        { }, -- For regexes.
    -- TSStringEscape       { }, -- For escape characters within a string.
    TSCharacter          { Character }, -- For characters.
    -- TSNumber             { }, -- For integers.
    -- TSBoolean            { }, -- For booleans.
    -- TSFloat              { }, -- For floats.
    -- TSFunction           { }, -- For function (calls and definitions).
    -- TSFuncBuiltin        { }, -- For builtin functions: `table.insert` in Lua.
    -- TSFuncMacro          { }, -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
    -- TSParameter          { }, -- For parameters of a function.
    -- TSParameterReference { }, -- For references to parameters of a function.
    -- TSMethod             { }, -- For method calls and definitions.
    -- TSField              { }, -- For fields.
    -- TSProperty           { }, -- Same as `TSField`.
    -- TSConstructor        { }, -- For constructor calls and definitions: `                                                                       { }` in Lua, and Java constructors.
    -- TSConditional        { }, -- For keywords related to conditionnals.
    -- TSRepeat             { }, -- For keywords related to loops.
    -- TSLabel              { }, -- For labels: `label:` in C and `:label:` in Lua.
    -- TSOperator           { fg = magenta }, -- For any operator: `+`, but also `->` and `*` in C.
    -- TSKeyword            { }, -- For keywords that don't fall in previous categories.
    -- TSKeywordFunction    { }, -- For keywords used to define a fuction.
    -- TSException          { }, -- For exception related keywords.
    TSType               { fg = '#ffffff' }, -- For types.
    -- TSTypeBuiltin        { }, -- For builtin types (you guessed it, right ?).
    -- TSNamespace          { }, -- For identifiers referring to modules and namespaces.
    -- TSInclude            { }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    -- TSAnnotation         { }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    -- TSText               { }, -- For strings considered text in a markup language.
    -- TSStrong             { }, -- For text to be represented with strong.
    -- TSEmphasis           { }, -- For text to be represented with emphasis.
    -- TSUnderline          { }, -- For text to be represented with an underline.
    -- TSTitle              { }, -- Text that is part of a title.
    -- TSLiteral            { }, -- Literal text.
    -- TSURI                { }, -- Any URI like a link or email.
    -- TSVariable           { }, -- Any variable name that does not have another highlight.
    -- TSVariableBuiltin    { }, -- Variable names that are defined by the languages, like `this` or `self`.
  }
end)

-- export-external
--
-- Integrating Lush with other tools:
--
-- By default, lush() actually returns your theme in parsed form. You can
-- interact with it in much the same way as you can inside a lush-spec.
--
-- This looks something like:
--
--   local theme = lush(function()
--     return {
--       Normal { fg = hsl(0, 100, 50) },
--       CursorLine { Normal },
--     }
--   end)
--
--   theme.Normal.fg()                     -- returns table {h = h, s = s, l = l}
--   tostring(theme.Normal.fg)             -- returns "#hexstring"
--   tostring(theme.Normal.fg.lighten(10)) -- you can still modify colours, etc
--
-- This means you can `require('my_lush_file')` in any lua code to access your
-- themes's color information.
--
-- Note:
--
-- "Linked" groups do not expose their colours, you can find the key
-- of their linked group via the 'link' key (may require chaining)
--
--   theme.CursorLine.fg() -- This is bad!
--   theme.CursorLine.link   -- = "Normal"
--
-- Also Note:
--
-- Most plugins expose their own Highlight groups, which *should be the primary
-- method for setting theme colours*, there are however some plugins that
-- require adjustments to a global or configuration variable.
--
-- To set a global variable, use neovims lua bridge,
--
--   vim.g.my_plugin.color_for_widget = theme.Normal.fg.hex
--
-- An example of where you may use this, might be to configure Lightline. See
-- the examples folder for two styles of this.
--
-- Exporting your theme beyond Lush:
--
-- If you wish to use your theme in Vim, or without loading lush, you may export
-- your theme via `lush.export_to_buffer(parsed_lush_spec)`. The readme has
-- further details on how to do this.

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap:cursorline:number

