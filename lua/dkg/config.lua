local nvim_lsp = require'nvim_lsp'

nvim_lsp.clangd.setup {
  cmd = {"/usr/local/Cellar/llvm/10.0.0_3/bin/clangd", "--background-index", "--cross-file-rename"},
  filetypes = {"c", "cpp"},
  on_attach = require'diagnostic'.on_attach
}

require'nvim-treesitter.configs'.setup{
  ensure_installed = {"c", "cpp", "lua", "html", "javascript", "markdown"},
  highlight = {
    enable = true,
    disable = {},
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      }
    }
  }
}
