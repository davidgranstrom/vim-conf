local map = require'dkg.utils'.map
local save_ve = {}

local function venn_toggle()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    vim.b.venn_enabled = true
    save_ve = vim.opt.virtualedit:get()
    vim.opt.virtualedit = 'all'
    -- draw a line on HJKL keystokes
    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
    -- draw a box by pressing "f" with visual selection
    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
  else
    vim.opt.virtualedit = save_ve
    vim.cmd[[mapclear <buffer>]]
    vim.b.venn_enabled = nil
  end
end

map('n', '<leader>v', '<cmd>lua require"dkg.configs.venn".toggle()<cr>')

return {
  toggle = venn_toggle
}
