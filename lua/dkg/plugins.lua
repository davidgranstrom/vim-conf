local fugitive = require'dkg.configs.fugitive'
local gitsigns = require'dkg.configs.gitsigns'
local indent_blankline = require'dkg.configs.indent-blankline'
local neogen = require'dkg.configs.neogen'
local nvim_cmp = require'dkg.configs.nvim-cmp'
local scnvim = require'dkg.configs.scnvim'
local surround = require'dkg.configs.surround'
local telescope = require'dkg.configs.telescope'
local unimpaired = require'dkg.configs.unimpaired'
local vim_tmux_navigator = require'dkg.configs.vim-tmux-navigator'

local config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}

local function plugins()
  use { 'wbthomason/packer.nvim' }
  use { 'lewis6991/impatient.nvim' }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-surround', config = surround }
  use { 'tpope/vim-abolish', cmd = 'S' }
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' }
  use { 'danymat/neogen', requires = 'nvim-treesitter/nvim-treesitter', config = neogen }
  use { 'justinmk/vim-dirvish' }
  use { 'neovim/nvim-lspconfig' }
  use { 'tpope/vim-fugitive', config = fugitive }
  use { 'norcalli/nvim-colorizer.lua', cmd = 'ColorizerAttachToBuffer' }
  use { 'L3MON4D3/LuaSnip', config = luasnip }
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim', config = gitsigns }
  use { '~/code/vim/scnvim', config = scnvim }
  use { 'bakpakin/fennel.vim' }
  use { 'lukas-reineke/indent-blankline.nvim', config = indent_blankline }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'alec-gibson/nvim-tetris', cmd = 'Tetris' }
  use { 'editorconfig/editorconfig-vim' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-unimpaired', config = unimpaired }
  use { '~/code/vim/nvim-markdown-preview', cmd = 'MarkdownPreview', }
  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.g.tokyonight_style = 'night'
      vim.cmd [[colorscheme tokyonight]]
      vim.cmd [[hi! link EndOfBuffer NonText]]
      vim.cmd [[hi! link VertSplit Normal]]
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = telescope
  }
  use {
    'christoomey/vim-tmux-navigator',
    setup = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    config = vim_tmux_navigator
  }
  -- use {
  --   'windwp/nvim-autopairs',
  --   config = function()
  --     require('nvim-autopairs').setup{}
  --   end
  -- }
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
end

require'packer'.startup({plugins, config = config})
