--- Commands

-- JSON formatting with jq
vim.cmd [[command! JSONPretty %!jq '.']]
vim.cmd [[command! JSONUgly %!jq -c '.']]

--- Easy printing
_G.P = function(...)
  local num = select("#", ...)
  local args = {...}
  local result = ''
  for i = 1, num do
    result = result .. vim.inspect(args[i])
    if i ~= num then
      result = result .. ' '
    end
  end
  print(result)
end

--- Create a new temporary buffer for SuperCollider code.
function sc_scratchpad_new()
  local dir = '/tmp'
  local fd = uv.fs_opendir(dir, nil, 100)
  local scratchpads = {}
  uv.fs_readdir(fd, function(err, entries)
    if err then
      return err
    end
    for _, entry in ipairs(entries) do
      local ext = entry.name:match('^.+(%..+)')
      if ext == '.scd' then
        local name = entry.name:match('^sc_scratchpad_')
        if name then
          scratchpads[#scratchpads + 1] = tonumber(entry.name:match('%d+'))
        end
      end
    end
    uv.fs_closedir(fd)
    table.sort(scratchpads)
    local num = scratchpads[#scratchpads] and scratchpads[#scratchpads] + 1 or 0
    local filename = string.format('sc_scratchpad_%d.scd', num) 
    vim.schedule(function()
      vim.cmd('new')
      vim.cmd(string.format('edit %s/%s', dir, filename))
      local lines = {
        string.format('// %s', string.rep('=', 78)),
        string.format('// sc scratchpad #%d', num),
        string.format('// %s', string.rep('=', 78)),
      }
      api.nvim_buf_set_lines(0, 0, 0, true, lines)
    end)
  end)
end

--- Split a single line function call into one parameter per line
function split_single_call()
  local lnum, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_mark(0, '<', lnum, col, {})
  -- find the open paren
  vim.cmd[[normal! f(]]
  vim.cmd[[exe "normal! a\<cr>"]]
  -- find the closing paren
  vim.cmd[[normal! f)]]
  vim.cmd[[exe "normal! i\<cr>\<esc>k"]]
  -- perform the split
  vim.cmd[[s/,/,\r/g]]
  lnum, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_mark(0, '>', lnum, col, {})
  -- reindent
  vim.cmd[[normal! vgv=]]
end

--- Keymap wrappers
local function map(mode, lhs, rhs, opts, bufnr)
  opts = opts or {}
  opts = vim.tbl_extend('keep', {}, opts, {noremap = true})
  if type(mode) ~= 'table' then
    mode = {mode}
  end
  for _, m in ipairs(mode) do
    if bufnr then
      vim.api.nvim_buf_set_keymap(bufnr, m, lhs, rhs, opts)
    else
      vim.api.nvim_set_keymap(m, lhs, rhs, opts)
    end
  end
end

local function buf_map(bufnr, mode, lhs, rhs, opts)
  map(mode, lhs, rhs, opts, bufnr)
end

return {
  map = map,
  buf_map = buf_map,
}
