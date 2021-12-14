local scnvim = require'scnvim'

-- Get the help source URI for "subject"
-- @param subject The subject to find
-- @param cb A callback which gets the URI as its first argument
local function get_help_uri(subject, cb)
  local cmd = [[SCDoc.helpSourceDir +/+ \"Classes\" +/+ \"%s\" ++ \".schelp\"]]
  cmd = string.format(cmd, subject)
  scnvim.eval(cmd, cb)
end

-- Open the help source file for the word under the cursor
return function()
  local subject = vim.fn.expand('<cword>')
  get_help_uri(subject, function(result)
    result = string.format('edit %s', result)
    vim.cmd(result)
  end)
end
