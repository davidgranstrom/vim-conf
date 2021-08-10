require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c",
    "cpp",
    "c_sharp",
    "zig",
    "lua",
    "html",
    "javascript",
    "css",
    "scss",
    "tsx",
    "typescript",
    "json",
    "yaml",
    "dockerfile",
    -- "supercollider",
  },
  highlight = {
    enable = true,
    disable = {},
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<Enter>",
      node_incremental = "<Enter>",
      node_decremental = "<BS>",
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
