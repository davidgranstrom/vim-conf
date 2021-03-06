local actions = require'telescope.actions'
local sorters = require'telescope.sorters'
local previewers = require'telescope.previewers'

require'telescope'.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-o>'] = actions.select_default,
        ['<Tab>'] = actions.toggle_selection,
        ['<C-w>'] = actions.send_selected_to_qflist,
        ['<C-q>'] = actions.send_to_qflist,
      },
      n = {
        ['<Tab>'] = actions.toggle_selection,
        ['<C-w>'] = actions.send_selected_to_qflist,
        ['<C-q>'] = actions.send_to_qflist,
      },
    },
    preview_cutoff = 120,
    color_devicons = true,
    file_sorter = sorters.get_fzy_sorter,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
  },
}
