vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.fileencoding = "utf-8"

vim.opt.mouse = 'a'

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.colorcolumn = "100"

-- Default tab settings. Most of the time these will be overridden by vim-sleuth.
-- If something is not working in a project, consider a .editorconfig file to override.
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.scrolloff = 10

vim.g.have_nerd_font = true
