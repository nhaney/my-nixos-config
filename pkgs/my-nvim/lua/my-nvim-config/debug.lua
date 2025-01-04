vim.fn.sign_define('DapBreakpoint', {
    text = '⬤',
    texthl = 'ErrorMsg',
    linehl = '',
    numhl = 'ErrorMsg'
})


vim.fn.sign_define('DapBreakpointCondition', {
    text = '⬤',
    texthl = 'ErrorMsg',
    linehl = '',
    numhl = 'SpellBad'
})

require("nvim-dap-virtual-text").setup()
require("dapui").setup({
    layouts = {
        {
            elements = {
                {
                    id = "scopes",
                    size = 0.70
                },
                {
                    id = "breakpoints",
                    size = 0.10
                },
                {
                    id = "stacks",
                    size = 0.20
                }
            },
            position = "left",
            size = 50
        },
        {
            elements = {
                {
                    id = "repl",
                    size = 1
                }
            },
            position = "bottom",
            size = 10
        }
    },
})

vim.keymap.set('n', '<F1>', ":lua require'dap'clear_breakpoints()<CR>")
vim.keymap.set('n', '<F2>', ":lua require'dapui'.float_element('scopes', {position = 'center',  enter = true })<CR>")
vim.keymap.set('n', '<F3>', ":lua require'dapui'.float_element('console', {position = 'center'})<CR>")
vim.keymap.set('n', '<F4>', ":lua require'dapui'.toggle()<CR>")
vim.keymap.set('n', '<F5>', ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set('n', '<F6>', ":lua require'dap'.continue()<CR>")
vim.keymap.set('n', '<F7>', ":lua require'dap'.restart()<CR>")
vim.keymap.set('n', '<F8>', ":lua require'dap'.step_over()<CR>")
vim.keymap.set('n', '<F9>', ":lua require'dap'.step_into()<CR>")
vim.keymap.set('n', '<F10>', ":lua require'dap'.step_out()<CR>")
