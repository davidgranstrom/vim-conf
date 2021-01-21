local actions = require'telescope.actions'
local sorters = require'telescope.sorters'
require'telescope'.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-o>'] = actions.goto_file_selection_edit,
      },
    },
    preview_cutoff = 120,
    file_sorter = sorters.get_fzy_sorter
  },
}
