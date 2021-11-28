-- keymap helper
function set_keymap(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts or {})
end

function editing(use)
  -- use {
  --   'tmsvg/pear-tree',
  --   setup = function()
  --     vim.g.pear_tree_repeatable_expand = 0
  --     vim.g.pear_tree_smart_openers = 1
  --     vim.g.pear_tree_smart_closers = 1
  --     vim.g.pear_tree_smart_backspace = 1
  --     vim.g.pear_tree_ft_disabled = {'TelescopePrompt'}
  --   end
  -- }
  -- use {
  --   'windwp/nvim-autopairs',
  --   config = function()
  --     require('nvim-autopairs').setup{}
  --   end
  -- }
  use 'tpope/vim-commentary'
  use {
    'tpope/vim-surround',
    config = function()
      set_keymap('x', 's', '<plug>VSurround')
    end
  }
  use {
    'tpope/vim-abolish',
    cmd = 'S'
  }
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
  }
  use {
    'danymat/neogen',
    config = function()
      require'neogen'.setup {
        enabled = true,
        languages = {
          c = {
            template = {
              annotation_convention = "my_doxygen",
              my_doxygen = {
                { nil, "/* $1 */", { no_results = true } },
                { nil, "/**" },
                { nil, " * @brief $1" },
                { "parameters", " * @param %s $1" },
                { "return_statement", " * @returns $1" },
                { nil, " */" },
              },
            },
          },
        },
      }
      set_keymap('n', '<leader>d', '<cmd>lua require"neogen".generate()<cr>', {noremap = true, silent = true})
    end,
    requires = 'nvim-treesitter/nvim-treesitter',
  }
end

function navigation(use)
  use 'justinmk/vim-dirvish'
  use {
    'christoomey/vim-tmux-navigator',
    setup = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    config = function()
      local mappings = {
        {'<A-h>', '<cmd>TmuxNavigateLeft<cr>'},
        {'<A-j>', '<cmd>TmuxNavigateDown<cr>'},
        {'<A-k>', '<cmd>TmuxNavigateUp<cr>'},
        {'<A-l>', '<cmd>TmuxNavigateRight<cr>'},
      }
      for _, maps in ipairs(mappings) do
        local map, action = unpack(maps)
        set_keymap('n', map, action, {noremap = true, silent = true})
      end
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local cmd = '<cmd>Telescope %s<cr>'
      local providers = {
        {'<leader>t', 'git_files'},
        {'<leader>b', 'buffers'},
        {'<leader>g', 'live_grep'},
        {'<leader>i', 'grep_string'},
      }
      for _, provider in ipairs(providers) do
        local map, action = unpack(provider)
        set_keymap('n', map, string.format(cmd, action), {noremap = true, silent = true})
      end
    end
  }
end

function utils(use)
  use 'neovim/nvim-lspconfig'
  use {
    'tpope/vim-fugitive',
    config = function()
      set_keymap('n', '<leader>fs', ':Git<cr>')
    end
  }
  use {
    'norcalli/nvim-colorizer.lua',
    cmd = 'ColorizerAttachToBuffer'
  }
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      set_keymap('i', '<C-j>', '<cmd>lua require"luasnip".expand_or_jump()<cr>', {noremap = true, silent = false})
      set_keymap('i', '<C-k>', '<cmd>lua require"luasnip".jump(-1)<cr>', {noremap = true, silent = false})
    end
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'quangnguyen30192/cmp-nvim-tags',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require'cmp'
      cmp.setup {
        completion = {
          keyword_length = 3,
        },
        experimental = {
          native_menu = false,
          ghost_text = false
        },
        -- documentation = false,
        mapping = {
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
      },
      sources = {
          {
            name = 'nvim_lsp',
            max_item_count = 30,
          },
          { name = 'tags' },
          { name = 'path' },
          { name = 'buffer' },
        },
      }
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup{
        keymaps = {
          noremap = true,
          ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
          ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},
        }
      }
    end
  }
end

function language(use)
  use {
    '~/code/vim/scnvim',
    config = function()
      -- require'scnvim'.setup{}
        -- postwin = {
        --   syntax = true,
        --   scrollback = 1000,
        -- },
        -- snippet = {
        --   style = 'default',
        --   engine = {
        --     name = 'luasnip'
        --   }
        -- }
      require'luasnip'.snippets.supercollider = require'scnvim.utils'.get_snippets()
      set_keymap('n', '<leader>st', '<cmd>SCNvimStart<cr>')
      set_keymap('n', '<leader>sk', '<Plug>(scnvim-recompile)')
      set_keymap('n', '<leader>sn', '<cmd>lua sc_scratchpad_new()<cr>')
      vim.g.scnvim_echo_args = 1
      -- vim.g.scnvim_eval_flash_duration = 0
      -- vim.g.scnvim_snippet_format = 'luasnip'
    end
  }
  use 'bakpakin/fennel.vim'
end

function appearance(use)
  use {
    'folke/tokyonight.nvim',
    setup = function()
      vim.g.tokyonight_style = 'night'
    end,
    config = function()
      vim.cmd [[colorscheme tokyonight]]
      vim.cmd [[hi! link EndOfBuffer NonText]]
      vim.cmd [[hi! link VertSplit Normal]]
    end
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require'indent_blankline'.setup{
        char = '│',
        filetype_exclude = {'terminal', 'help', 'scnvim', 'git', 'markdown', 'fennel', 'packer'},
        show_first_indent_level = false,
        -- show_current_context = true,
        -- show_current_context_start = false,
      }
    end
  }
  use 'kyazdani42/nvim-web-devicons'
end

function misc(use)
  use {
    'alec-gibson/nvim-tetris',
    cmd = 'Tetris'
  }
  use 'editorconfig/editorconfig-vim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-unimpaired'
  use {
    '~/code/vim/nvim-markdown-preview',
    cmd = 'MarkdownPreview',
  }
end

return require'packer'.startup({function()
  use 'wbthomason/packer.nvim'
  navigation(use)
  editing(use)
  utils(use)
  language(use)
  appearance(use)
  misc(use)
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
