local api = vim.api
local uv = vim.loop

P = function(x)
  print(vim.inspect(x))
  return x
end

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

-- sc_scratchpad_new()

-- require'shade'.setup {
--   overlay_opacity = 50,
-- }
-- require "pears".setup()

