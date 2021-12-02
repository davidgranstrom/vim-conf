local set = vim.opt

-------------
-- Editing --
-------------

-- work-around for nvim-cmp
set.virtualedit = {'block', 'insert'}

-- yank to system-wide clipboard
set.clipboard = 'unnamed'

-- popup menu behaviour (completion)
set.completeopt = {'menu', 'menuone', 'noselect'}

-- enable mouse
set.mouse = 'a'

----------------
-- Appearance --
----------------

-- enable true color
set.termguicolors = true

-- keep a distance from the cursor when scrolling
set.scrolloff = 4

-- don't wrap words
set.wrap = false

-- break at word boundries for wrapped text
set.linebreak = true

-- don't display partial commands (g,c etc.)
set.showcmd = false

-- columns left/right of cursor for nowrap
set.sidescrolloff = 1

-- pop-up menu transparency
set.pumblend = 10

-- show list chars
set.list = true

-- highlight trailing whitespace
set.listchars:append('trail:∙')

---------------
-- Searching --
---------------

-- ignore case in search patterns
set.ignorecase = true

-- overrides 'ignorecase'
set.smartcase = true

-- highlight search matches while typing
set.showmatch = false

----------------
-- Formatting --
----------------

-- width of a <Tab> character
set.tabstop = 2

-- Ignore soft tab stop (use shiftwidth value instead)
set.softtabstop = -1

-- shiftwidth
set.shiftwidth = 2

-- copy indent chars from previous line
set.copyindent = true

-- use whitespace instead of tabs
set.expandtab = true

-- round indent to multiples of 'shiftwidth'
set.shiftround = true

----------
-- Misc --
----------

-- be smart case-sensitive
set.wildignorecase = true

-- don't redraw screen for macros
set.lazyredraw = true

-- use vertical diffs
set.diffopt:append('vertical')

-----------------
-- Diagnostics --
-----------------

vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = false,
  signs = true,
})
