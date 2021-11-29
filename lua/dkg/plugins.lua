local telescope = require'dkg.plugins.telescope'
local surround = require'dkg.plugins.surround'
local neogen = require'dkg.plugins.neogen'
local fugitive = require'dkg.plugins.fugitive'
local nvim_cmp = require'dkg.plugins.nvim-cmp'
local vim_tmux_navigator = require'dkg.plugins.vim-tmux-navigator'
local gitsigns = require'dkg.plugins.gitsigns'
local scnvim = require'dkg.plugins.scnvim'
local indent_blankline = require'dkg.plugins.indent-blankline'

local config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}

local function plugins()
  use { 'wbthomason/packer.nvim' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-surround', config = surround }
  use { 'tpope/vim-abolish', cmd = 'S' }
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' }
  use {
    'danymat/neogen',
    requires = 'nvim-treesitter/nvim-treesitter',
    config = neogen,
  }
  use { 'justinmk/vim-dirvish' }
  use {
    'christoomey/vim-tmux-navigator',
    setup = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    config = vim_tmux_navigator
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = telescope
  }
  use { 'neovim/nvim-lspconfig' }
  use {
    'tpope/vim-fugitive',
    config = fugitive
  }
  use {
    'norcalli/nvim-colorizer.lua',
    cmd = 'ColorizerAttachToBuffer'
  }
  use {
    'L3MON4D3/LuaSnip',
    config = luasnip
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
    config = nvim_cmp
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = gitsigns
  }
  use {
    '~/code/vim/scnvim',
    config = scnvim
  }
  use { 'bakpakin/fennel.vim' }
  use {
    'folke/tokyonight.nvim',
    setup = function()
      vim.g.tokyonight_style = 'night'
    end,
    -- config = function()
    --   vim.cmd [[colorscheme tokyonight]]
    --   vim.cmd [[hi! link EndOfBuffer NonText]]
    --   vim.cmd [[hi! link VertSplit Normal]]
    -- end
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = indent_blankline
  }
  use { 'kyazdani42/nvim-web-devicons' }
  use {
    'alec-gibson/nvim-tetris',
    cmd = 'Tetris'
  }
  use { 'editorconfig/editorconfig-vim' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-unimpaired' }
  use {
    '~/code/vim/nvim-markdown-preview',
    cmd = 'MarkdownPreview',
  }
  -- use {
  --   'windwp/nvim-autopairs',
  --   config = function()
  --     require('nvim-autopairs').setup{}
  --   end
  -- }
end

require'packer'.startup({plugins, config})
