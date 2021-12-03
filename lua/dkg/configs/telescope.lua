local keymap = require'dkg.utils'.map
local actions = require'telescope.actions'
local sorters = require'telescope.sorters'
local previewers = require'telescope.previewers'

require'telescope'.setup{
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
    -- preview_cutoff = 120,
    color_devicons = true,
    file_sorter = sorters.get_fzy_sorter,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
  },
}

local cmd = '<cmd>Telescope %s<cr>'
local providers = {
  {'<leader>t', 'git_files'},
  {'<leader>b', 'buffers'},
  {'<leader>g', 'live_grep'},
  {'<leader>i', 'grep_string'},
}

for _, provider in ipairs(providers) do
  local map, action = unpack(provider)
  keymap('n', map, string.format(cmd, action), {silent = true})
end
