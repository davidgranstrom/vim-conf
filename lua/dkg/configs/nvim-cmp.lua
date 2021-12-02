return function()
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end
  local lspkind = require'lspkind'
  local luasnip = require'luasnip'
  local cmp = require'cmp'
  cmp.setup {
    snippet = {
      expand = function(args)
        require'luasnip'.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    completion = {
      keyword_length = 3,
    },
    experimental = {
      native_menu = false,
      ghost_text = false,
    },
    documentation = false,
    formatting = {
      format = lspkind.cmp_format({preset = 'default', with_text = false, maxwidth = 50})
    },
    mapping = {
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'tags' },
      { name = 'path' },
      { name = 'buffer' },
      { name = 'luasnip' },
    },
  }
end
