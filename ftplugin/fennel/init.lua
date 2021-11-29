local map = vim.api.nvim_set_keymap

function _G.love2d_reload()
  local filename = vim.fn.expand('%:p:t:r')
  local cmd = string.format('(lume.hotswap "%s")', filename)
  local job = vim.fn.jobstart({'tmux', 'send-keys', '-t', 1, cmd, 'Enter'})
end

map('n', '<F5>', '<cmd> lua love2d_reload()<cr>', {noremap = true, silent = true})
