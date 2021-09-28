local lsp = require'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

-- vim.o.updatetime = 150
-- vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

lsp.clangd.setup {
  cmd = {
    '/usr/local/Cellar/llvm/12.0.1/bin/clangd',
    '--background-index',
    '--cross-file-rename',
    '--clang-tidy',
  },
  filetypes = {'c', 'cpp'},
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 25,
  }
}

lsp.cmake.setup{
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 25,
  }
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  })

-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end

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
