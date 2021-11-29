return function()
  local map = require'dkg.utils'.map
  map('i', '<C-j>', '<cmd>lua require"luasnip".expand_or_jump()<cr>', {silent = false})
  map('i', '<C-k>', '<cmd>lua require"luasnip".jump(-1)<cr>', {silent = false})
end
