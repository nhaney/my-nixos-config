-- Map the leader key.
vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>n', '<cmd>bnext<CR>')
vim.keymap.set('n', '<leader>p', '<cmd>bprevious<CR>')
vim.keymap.set('n', '<leader>d', '<cmd>bdelete<CR>')
vim.keymap.set('n', '<leader>x', '<cmd>%bd|e#|bd#<CR>', { desc = 'Close all buffers except current' })


-- Reselect text after indent/unindent.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- correct :W to :w typo
vim.api.nvim_command("cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))")
-- correct :Q to :q typo
vim.api.nvim_command("cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))")

-- TODO: Make this more generic or use a plugin. With netrw disabled this is how to open links.
vim.keymap.set("n", "gx", [[:silent execute 'firefox ' . shellescape(expand('<cfile>'), 1)<CR>]])


vim.keymap.set("n", "<leader>?", "<cmd>lua require('which-key').show({ global = false })<CR>")
