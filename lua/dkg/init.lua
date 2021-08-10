local api = vim.api
local uv = vim.loop

require'dkg.config.lsp'
require'dkg.config.treesitter'
require'dkg.config.telescope'
require'dkg.config.dap'
-- require'random'
-- require'make'

--- Easy printing
_G.P = function(x)
  print(vim.inspect(x))
  return x
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
    buftype_exclude = {'terminal', 'help', 'scnvim', 'git', 'markdown'},
    show_first_indent_level = false,
}

--- auto completion
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 3;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;
  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lsp = true;
    nvim_lua = true;
    tags = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

--- This line is important for auto-import
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })
