require'indent_blankline'.setup{
  char = '│',
  filetype_exclude = {
    'terminal',
    'help',
    'lspinfo',
    'checkhealth',
    'packer',
    'scnvim',
    'git',
    'markdown',
    'fennel',
    '',
  },
  show_first_indent_level = false,
  show_current_context = true,
  -- show_current_context_start = false,
}
