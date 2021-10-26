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
    run = 'TSUpdate'
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
  }
  use {
    'nvim-treesitter/playground',
    cmd = 'TSPlaygroundToggle',
  }
  use {
    '~/code/vim/neogen',
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
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require'cmp'
      local luasnip = require'luasnip'
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      cmp.setup {
        completion = {
          keyword_length = 3,
        },
        snippet = {
          expand = function(args)
            require'luasnip'.lsp_expand(args.body)
          end
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          {
            name = 'nvim_lsp',
            max_item_count = 30,
          },
          { name = 'luasnip' },
          { name = 'buffer' },
        },
      }
      ---- snippets
      local snip_loader = require'luasnip.loaders.from_vscode'
      snip_loader.lazy_load()
    end
  }
  use {
    'mfussenegger/nvim-dap',
    requires = {
      'theHamsta/nvim-dap-virtual-text',
    }
  }
  use {
    'jbyuki/venn.nvim',
    -- cmd = 'VBox'
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
      set_keymap('n', '<leader>st', '<cmd>SCNvimStart<cr>')
      set_keymap('n', '<leader>sk', '<Plug>(scnvim-recompile)')
      set_keymap('n', '<leader>sn', '<cmd>lua sc_scratchpad_new()<cr>')
      vim.g.scnvim_echo_args = 1
      vim.g.scnvim_snippet_format = 'luasnip'
    end
  }
  -- use {
  --   'Olical/conjure',
  --   tag = 'v4.23.0',
  --   ft = 'fennel',
  --   setup = function()
  --     vim.g['conjure#filetype#fennel'] = 'conjure.client.fennel.stdio'
  --   end
  -- }
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
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require'indent_blankline'.setup{
        char = '│',
        filetype_exclude = {'terminal', 'help', 'scnvim', 'git', 'markdown', 'fennel'},
        show_first_indent_level = false,
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

return require'packer'.startup(function()
  use 'wbthomason/packer.nvim'
  navigation(use)
  editing(use)
  utils(use)
  language(use)
  appearance(use)
  misc(use)
end)
