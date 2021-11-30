return function()
  local map = require'dkg.utils'.map
  map('n', '<leader>st', '<cmd>SCNvimStart<cr>')
  map('n', '<leader>sk', '<Plug>(scnvim-recompile)', {noremap = false})
  map('n', '<leader>sn', '<cmd>lua sc_scratchpad_new()<cr>')
  -- require'luasnip'.snippets.supercollider = require'scnvim.utils'.get_snippets()
  vim.g.scnvim_echo_args = 1
  vim.g.scnvim_echo_args_float = 0
end
