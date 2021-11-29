local lsp = require'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

local on_attach = function(_, bufnr)
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>o', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', [[<cmd>lua require'telescope.builtin'.lsp_references()<CR>]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>y', [[<cmd>lua require'telescope.builtin'.lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  vim.cmd [[ command! -buffer -nargs=? ReplaceAll lua vim.lsp.buf.rename(<args>)<CR> ]]
end

lsp.clangd.setup {
  cmd = {
    '/usr/local/Cellar/llvm/12.0.1/bin/clangd',
    '--background-index',
    '--cross-file-rename',
    '--clang-tidy',
  },
  on_attach = on_attach,
  filetypes = {'c', 'cpp'},
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 10,
  }
}

lsp.cmake.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 10,
  }
}

lsp.tsserver.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 10,
  }
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  update_in_insert = false,
})

-- vim.lsp.set_log_level(vim.lsp.log_levels.TRACE)

-- local configs = require'lspconfig/configs'
-- if not lsp.supercollider then
-- configs.supercollider = {
  --   default_config = {
    --       cmd = {'/Users/dkg/code/cpp/sclangd/build/sclangd'};
    --       filetypes = {'supercollider'};
    --       root_dir = function(fname)
      --         return vim.fn.getcwd()
      --       end;
      --   };
      --   settings = {};
      --   docs = {
        --     package_json = '';
        --     description = [[]];
        --     default_config = {
          --       root_dir = 'vim's starting directory';
          --     };
          --   };
          -- }
          -- end
          -- lsp.supercollider.setup{}
