local set = vim.o

-- Editing
set.hidden                                        -- be able to hide modified buffers
set.virtualedit = 'all'                           -- be able to access all areas of the buffer    
set.clipboard = 'unnamed'                         -- yank to system-wide clipboard
set.inccommand = 'nosplit'                        -- preview changes (:s/) incrementally
set.completeopt = {'menu', 'menuone', 'noselect'} -- popup menu behaviour (completion)

-- Appearance
set.termguicolors      -- enable true color
set.scrolloff = 4      -- keep a distance of from the cursor when scrolling
set.nowrap             -- don't wrap words
set.linebreak          -- break at word boundries for wrapped text
set.noshowcmd          -- don't display partial commands (g,c etc.)
set.sidescrolloff = 1
set.pumblend = 10

-- Searching
set.ignorecase -- ignore case in search patterns
set.smartcase  -- overrides 'ignorecase'
set.showmatch  -- highlight search matches while typing

-- Misc
set.wildignorecase             -- be smart case-sensitive
set.lazyredraw                 -- don't redraw screen for macros
set.diffopt:append('vertical') -- use vertical diffs by default

-- Idendation/Formating
set.tabstop = 2     -- tabstop
set.softtabstop = 2 -- soft tab stop
set.shiftwidth = 2  -- shiftwidth
set.copyindent      -- copy indent chars from previous line
set.expandtab       -- use whitespace instead of tabs
set.shiftround      -- round indent to multiples of 'shiftwidth'
set.nojoinspaces    -- only insert one space after a join command
