-- keymap helper
function set_keymap(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts or {})
end

function editing(use)
  use {
    'tmsvg/pear-tree',
    setup = function()
      vim.g.pear_tree_repeatable_expand = 0
      vim.g.pear_tree_smart_openers = 1
      vim.g.pear_tree_smart_closers = 1
      vim.g.pear_tree_smart_backspace = 1
      vim.g.pear_tree_ft_disabled = {'TelescopePrompt'}
    end
  }
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
  use {
    'nvim-treesitter/nvim-treesitter',
    branch = '0.5-compat',
    run = 'TSUpdate'
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = '0.5-compat',
  }
  use {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
  }
  use {
    'danymat/neogen',
    config = function()
      require'neogen'.setup {
        enabled = true
      }
    end
  }
  -- use 'gpanders/nvim-parinfer'
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
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
    }
  }
  use {
    'mfussenegger/nvim-dap',
    requires = {
      'theHamsta/nvim-dap-virtual-text',
    }
  }
  use {
    'jbyuki/venn.nvim',
    cmd = 'VBox'
  }
end

function language(use)
  use {
    '~/code/vim/scnvim',
    config = function()
      set_keymap('n', '<leader>st', '<cmd>SCNvimStart<cr>')
      set_keymap('n', '<leader>sk', '<Plug>(scnvim-recompile)')
      set_keymap('n', '<leader>sn', '<cmd>lua sc_scratchpad_new()<cr>')
    end
  }
  use {
    'Olical/conjure',
    tag = 'v4.23.0',
    ft = 'fennel',
    setup = function()
      vim.g['conjure#filetype#fennel'] = 'conjure.client.fennel.stdio'
    end
  }
  use 'bakpakin/fennel.vim'
  -- use {
  --   'ziglang/zig.vim',
  -- }
  -- use {
  --   'Olical/aniseed',
  --   tag = 'v3.21.0',
  -- }
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
  use 'lukas-reineke/indent-blankline.nvim'
  use 'kyazdani42/nvim-web-devicons'
end

function misc(use)
  use {
    'alec-gibson/nvim-tetris',
    cmd = 'Tetris'
  }
  use 'editorconfig/editorconfig-vim'
  use 'tpope/vim-repeat'
  use {
    'tpope/vim-unimpaired',
    config = function()
      -- unimpaired original mapping
      set_keymap('n', 'co', 'yo')
    end
  }
  use {
    '~/code/vim/nvim-markdown-preview',
    cmd = 'MarkdownPreview',
  }
end

return require'packer'.startup(function()
  use 'wbthomason/packer.nvim'
  navigation(use)
  editing(use)
  utils(use)
  language(use)
  appearance(use)
  misc(use)
end)
