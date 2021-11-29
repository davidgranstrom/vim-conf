--- Keymap wrapper
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts = vim.tbl_extend('keep', {}, opts, {noremap = true})
  if type(mode) ~= 'table' then
    mode = {mode}
  end
  for _, m in ipairs(mode) do
    vim.api.nvim_set_keymap(m, lhs, rhs, opts)
  end
end

return {
  map = map
}
