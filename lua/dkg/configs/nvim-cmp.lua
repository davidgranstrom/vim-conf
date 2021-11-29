return function()
  local cmp = require'cmp'
  cmp.setup {
    completion = {
      keyword_length = 3,
    },
    experimental = {
      native_menu = false,
      ghost_text = false
    },
    -- documentation = false,
    mapping = {
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = {
      {
        name = 'nvim_lsp',
        max_item_count = 30,
      },
      { name = 'tags' },
      { name = 'path' },
      { name = 'buffer' },
    },
  }
end
