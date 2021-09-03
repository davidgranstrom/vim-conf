return require'packer'.startup(function()
  use 'wbthomason/packer.nvim'
  use 'tmsvg/pear-tree'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-abolish'
  use {
    'nvim-treesitter/nvim-treesitter',
    branch = '0.5-compat',
    run = ':TSUpdate'
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = '0.5-compat',
  }
  use {
    'nvim-treesitter/playground',
    cmd = ':TSPlaygroundToggle'
  }
  use 'danymat/neogen'
  -- use 'gpanders/nvim-parinfer'

  -- navigation
  use 'christoomey/vim-tmux-navigator'
  use 'justinmk/vim-dirvish'

  -- util
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'

  use 'tpope/vim-fugitive'
  use 'norcalli/nvim-colorizer.lua'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'mfussenegger/nvim-dap'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'jbyuki/venn.nvim'

  -- language
  use '~/code/vim/scnvim'
  use {
    'ziglang/zig.vim',
    ft = 'zig',
  }
  use {
    'Olical/conjure',
    tag = 'v4.23.0',
    ft = 'fennel',
  }
  -- use {
  --   'Olical/aniseed',
  --   tag = 'v3.21.0',
  -- }
  use 'bakpakin/fennel.vim'

  -- color schemes / appearance
  use 'folke/tokyonight.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'kyazdani42/nvim-web-devicons'

  -- misc
  use {
    'alec-gibson/nvim-tetris',
    cmd = ':Tetris'
  }
  use 'editorconfig/editorconfig-vim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-unimpaired'
  use {
    '~/code/vim/nvim-markdown-preview',
    cmd = ':MarkdownPreview',
  }
  use '~/code/vim/osc.nvim'
end)
