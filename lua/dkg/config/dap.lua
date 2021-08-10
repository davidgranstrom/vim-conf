local dap = require'dap'

local M = {}
local last_config

local lldb = {
  type = 'executable',
  attach = {
    pidProperty = 'pid',
    pidSelect = 'ask'
  },
  command = '/usr/local/opt/llvm/bin/lldb-vscode',
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = 'YES'
  },
  name = 'lldb'
}

local lldb_conf = {
  type = 'lldb-vscode',
  request = 'launch',
  name = "Launch program",
  -- program = "${workspaceFolder}/build",
}

dap.adapters.c = lldb
dap.configurations.c = {
  lldb_conf
}

dap.adapters.cpp = lldb
dap.configurations.cpp = {
  lldb_conf
}

M.start = function(args)
  if args and #args > 0 then
    local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
    last_config = {
      type = ft,
      name = args[1],
      request = 'launch',
      program = table.remove(args, 1),
      args = args,
      cwd = vim.fn.getcwd(),
      externalConsole = true,
      MIMode = 'lldb',
    }
  end

  if not last_config then
    print('No binary set! Use ":Debug <binary> <args>"')
    return
  end

  dap.run(last_config)
  dap.repl.open()
end

vim.cmd [[
command! -complete=file -nargs=* Debug lua require'dkg.config.dap'.start({<f-args>})
]]
vim.cmd [[nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>]]

vim.g.dap_virtual_text = true

return M
