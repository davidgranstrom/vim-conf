return function()
  local map = require'dkg.utils'.map
  map('n', '<leader>st', '<cmd>SCNvimStart<cr>')
  map('n', '<leader>sk', '<Plug>(scnvim-recompile)', {noremap = false})
  map('n', '<leader>sn', '<cmd>lua sc_scratchpad_new()<cr>')

  -- local ls = require'luasnip'
  -- local s = ls.snippet
  -- local t = ls.text_node
  -- local i = ls.insert_node

  -- local local_snippets = {
  --   -- Ndef
  --   s("ndeftest",{
  --     t("Ndef("),
  --     t("\\"), i(1, "name"), t(",{|"), i(2, "freq=100, amp=0.5"), t({"|", ""}),
  --     t("\t"), i(2, "SinOsc.ar(freq) * amp;"), t({"", ""}),
  --     t({"", "})"}),
  --     i(3, ".play"),
  --   }),
  -- }
  -- local scnvim_snippets = require'scnvim.utils'.get_snippets()
  -- require'luasnip'.snippets.supercollider = vim.tbl_extend('force', {}, scnvim_snippets, local_snippets)

  vim.g.scnvim_echo_args = 1
end
