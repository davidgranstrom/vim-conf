local map = require'dkg.utils'.map

return function()
  map('n', '<leader>fs', ':Git<cr>')
end
