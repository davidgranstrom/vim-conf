--- JSON formatting with jq
vim.cmd [[command! JSONPretty %!jq '.']]
vim.cmd [[command! JSONUgly %!jq -c '.']]
