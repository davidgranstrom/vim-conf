return function()
  local keymap = require'dkg.utils'.map
  local mappings = {
    {'<A-h>', '<cmd>TmuxNavigateLeft<cr>'},
    {'<A-j>', '<cmd>TmuxNavigateDown<cr>'},
    {'<A-k>', '<cmd>TmuxNavigateUp<cr>'},
    {'<A-l>', '<cmd>TmuxNavigateRight<cr>'},
  }
  for _, maps in ipairs(mappings) do
    local map, action = unpack(maps)
    keymap('n', map, action, {silent = true})
  end
end
