local map = require'dkg.utils'.map
require'neogen'.setup{
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
map('n', '<leader>d', '<cmd>lua require"neogen".generate()<cr>', {silent = true})
