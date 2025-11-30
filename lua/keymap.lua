vim.g.mapleader = " "
local set = vim.keymap.set

-- Using OIL since 2025/12/01
--set("n", "<leader>pv", vim.cmd.Ex)

--set('', '<leader>y', '"+y', { desc = 'Yank to clipboard' })
set('', '<leader>Y', '"+y$', { desc = 'Yank until EOL to clipboard' })
set('n', '<leader>p', '"+p', { desc = 'Paste after cursor from clipboard' })
set('n', '<leader>P', '"+P', { desc = 'Paste before cursor from clipboard' })


set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line up" })

-- to exit terminal mode via esc
set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })


