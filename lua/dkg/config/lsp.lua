local lsp = require'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.update_capabilities(capabilities)

lsp.clangd.setup {
  cmd = {
    "/usr/local/Cellar/llvm/12.0.0_1/bin/clangd",
    "--background-index",
    "--cross-file-rename",
    "--clang-tidy",
  },
  filetypes = {"c", "cpp"},
  on_attach = on_attach,
  capabilities = capabilities,
}

lsp.cmake.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- This will disable virtual text, like doing:
    -- let g:diagnostic_enable_virtual_text = 0
    virtual_text = false,

    -- This is similar to:
    -- let g:diagnostic_show_sign = 1
    -- To configure sign display,
    --  see: ":help vim.lsp.diagnostic.set_signs()"
    signs = true,

    -- This is similar to:
    -- "let g:diagnostic_insert_delay = 1"
    update_in_insert = false,
  })


-- vim.lsp.set_log_level(vim.lsp.log_levels.TRACE)

-- local configs = require'lspconfig/configs'
-- if not lsp.supercollider then
-- configs.supercollider = {
--   default_config = {
--       cmd = {"/Users/dkg/code/cpp/sclangd/build/sclangd"};
--       filetypes = {"supercollider"};
--       root_dir = function(fname)
--         return vim.fn.getcwd()
--       end;
--   };
--   settings = {};
--   docs = {
--     package_json = "";
--     description = [[]];
--     default_config = {
--       root_dir = "vim's starting directory";
--     };
--   };
-- }
-- end
-- lsp.supercollider.setup{}
