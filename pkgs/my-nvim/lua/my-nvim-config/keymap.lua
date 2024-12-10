-- Map the leader key.
vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>n', '<cmd>bnext<CR>')
vim.keymap.set('n', '<leader>p', '<cmd>bprevious<CR>')
vim.keymap.set('n', '<leader>d', '<cmd>bdelete<CR>')

-- TODO: Make this more generic or use a plugin. With netrw disabled this is how to open links.
vim.keymap.set("n", "gx", [[:silent execute 'firefox ' . shellescape(expand('<cfile>'), 1)<CR>]])
