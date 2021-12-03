-- External plugins managed with packer.nvim
--
-- The plugin configuration is required inline with the plugin declaration,
-- which makes it possible to temporarily disable a plugin by just commenting
-- the declaration.

--- Requires a plugin configuration.
---@param cfg The name of the config to require.
local r = function(cfg)
  local module = string.format('dkg.configs.%s', cfg)
  require(module)
end

local function plugins()
  use { 'wbthomason/packer.nvim' }
  use { 'lewis6991/impatient.nvim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'nvim-treesitter/nvim-treesitter' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' }
  use { '~/code/vim/scnvim', config = r'scnvim' }
  use { '~/code/vim/nvim-markdown-preview', cmd = 'MarkdownPreview', }
  use { 'tpope/vim-commentary' }
  use { 'tpope/vim-surround', config = r'surround' }
  use { 'tpope/vim-abolish', cmd = 'S' }
  use { 'tpope/vim-fugitive', config = r'fugitive' }
  use { 'tpope/vim-repeat' }
  use { 'tpope/vim-unimpaired', config = r'unimpaired' }
  use { 'editorconfig/editorconfig-vim' }
  use { 'numToStr/Navigator.nvim', config = r'navigator' }
  use { 'justinmk/vim-dirvish' }
  use { 'danymat/neogen', requires = 'nvim-treesitter/nvim-treesitter', config = r'neogen' }
  use { 'norcalli/nvim-colorizer.lua', cmd = 'ColorizerAttachToBuffer' }
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim', config = r'gitsigns' }
  use { 'bakpakin/fennel.vim' }
  use { 'lukas-reineke/indent-blankline.nvim', config = r'indent-blankline' }
  use { 'alec-gibson/nvim-tetris', cmd = 'Tetris' }
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
    config = r'telescope'
  }
  use { 'L3MON4D3/LuaSnip', config = r'luasnip' }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'quangnguyen30192/cmp-nvim-tags',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
      'kyazdani42/nvim-web-devicons'
    },
    config = r'nvim-cmp'
  }
  -- use {
  --   'windwp/nvim-autopairs',
  --   config = function()
  --     require('nvim-autopairs').setup{}
  --   end
  -- }
end

local packer_config = {
  display = {
    open_fn = function()
      return require'packer.util'.float({ border = 'single' })
    end
  }
}

require'packer'.startup({plugins, config = packer_config})
