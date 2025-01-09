-- Map the leader key.
vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<CR>', { desc = 'Go to next buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<CR>', { desc = 'Go to previous buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>bx', '<cmd>%bd|e#|bd#<CR>', { desc = 'Close all buffers except current' })


-- Reselect text after indent/unindent.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- correct :W to :w typo
vim.api.nvim_command("cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))")
-- correct :Q to :q typo
vim.api.nvim_command("cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))")

-- TODO: Make this more generic or use a plugin. With netrw disabled this is how to open links.
vim.keymap.set("n", "gx", [[:silent execute 'firefox ' . shellescape(expand('<cfile>'), 1)<CR>]])


vim.keymap.set("n", "<leader>?", function() require('which-key').show({ global = false }) end)
