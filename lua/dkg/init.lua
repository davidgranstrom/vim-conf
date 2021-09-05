local api = vim.api
local uv = vim.loop

require'dkg.plugins'
require'dkg.config.lsp'
require'dkg.config.treesitter'
require'dkg.config.telescope'
require'dkg.config.dap'
-- require'random'
-- require'make'

--- Easy printing
_G.P = function(...)
  local num = select("#", ...)
  local args = {...}
  for i = 1, num do
    print(vim.inspect(args[i]))
  end
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

--- Indent guides
require'indent_blankline'.setup{
    char = '│',
    filetype_exclude = {'terminal', 'help', 'scnvim', 'git', 'markdown', 'fennel'},
    show_first_indent_level = false,
}

--- auto completion
local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

require'cmp'.setup {
  -- You can set mappings if you want
  -- mapping = {
  --   ['<C-p>'] = cmp.mapping.select_prev_item(),
  --   ['<C-n>'] = cmp.mapping.select_next_item(),
  --   ['<C-d>'] = cmp.mapping.scroll_docs(-4),
  --   ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --   ['<C-Space>'] = cmp.mapping.complete(),
  --   ['<C-e>'] = cmp.mapping.close(),
  --   ['<CR>'] = cmp.mapping.confirm({
  --     behavior = cmp.ConfirmBehavior.Insert,
  --     select = true,
  --   })
  -- },

  mapping = {
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif check_back_space() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n')
      elseif vim.fn['vsnip#available']() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
      else
        fallback()
      end
    end,
  },

  sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp' },
  },
}
