local lsp = require'lspconfig'
local lsp_mappings = require'dkg.mappings'.lsp_mappings

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
-- if ok then
--   capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
-- end

local on_attach = function(_, bufnr)
  lsp_mappings(bufnr)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  vim.cmd [[ command! -buffer -nargs=? ReplaceAll lua vim.lsp.buf.rename(<args>)<CR> ]]
end

local servers = {
  clangd = {
    cmd = {
      '/usr/local/Cellar/llvm/13.0.0_1/bin/clangd',
      '--background-index',
      '--cross-file-rename',
      '--clang-tidy',
    },
    filetypes = {'c', 'cpp'},
  },
  cmake = {},
  tsserver = {},
}

for name, cfg in pairs(servers) do
  local config = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  config = vim.tbl_extend('keep', config, cfg)
  lsp[name].setup(config)
end

-- vim.lsp.set_log_level(vim.lsp.log_levels.TRACE)
-- local configs = require'lspconfig/configs'
-- if not lsp.supercollider then
--   configs.supercollider = {
--     default_config = {
--       cmd = {'/Users/dkg/code/cpp/sclangd/build/sclangd'};
--       filetypes = {'supercollider'};
--       root_dir = function(fname)
--         return vim.fn.getcwd()
--       end;
--     };
--     settings = {};
--     docs = {
--       package_json = '';
--       description = [[]];
--       default_config = {
--         root_dir = 'vim's starting directory';
--       };
--     };
--   }
-- end
-- lsp.supercollider.setup{}
