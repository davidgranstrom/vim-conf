local map = require'dkg.utils'.map

require('Navigator').setup()

map('n', '<A-k>', '<cmd>lua require"Navigator".up()<cr>', {silent = true})
map('n', '<A-l>', '<cmd>lua require"Navigator".right()<cr>', {silent = true})
map('n', '<A-j>', '<cmd>lua require"Navigator".down()<cr>', {silent = true})
map('n', '<A-h>', '<cmd>lua require"Navigator".left()<cr>', {silent = true})
