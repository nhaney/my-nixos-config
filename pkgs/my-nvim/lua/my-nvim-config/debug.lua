-- vim.fn.sign_define('DapBreakpoint', {
--     text = '⬤',
--     texthl = 'ErrorMsg',
--     linehl = '',
--     numhl = 'ErrorMsg'
-- })
--
--
-- vim.fn.sign_define('DapBreakpointCondition', {
--     text = '⬤',
--     texthl = 'ErrorMsg',
--     linehl = '',
--     numhl = 'SpellBad'
-- })
require("nvim-dap-virtual-text").setup()

local dap = require('dap')
local ui = require('dapui')
ui.setup()

vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = "Debug: Continue" })
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = "Debug: Step over" })
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = "Debug: Step into" })
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = "Debug: Step out" })
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end,
    { desc = "Debug: Toggle breakpoint" })
vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end, { desc = "Debug: Set breakpoint" })
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end,
    { desc = "Debug: Run last debugging configuration" })
vim.keymap.set('n', '<Leader>dx', function() require('dap').terminate() end,
    { desc = "Debug: Terminate debugging session" })
-- Other options from nvim-dap. Not currently using them.
--vim.keymap.set('n', '<Leader>lp',
--    function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = "Debug: XXX" })
--vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, { desc = "Debug: XXX" })

vim.keymap.set("n", "<leader>d?", function()
    require("dapui").eval(nil, { enter = true })
end, { desc = "Debug: Evaluate under cursor." })

dap.listeners.before.attach.dapui_config = function()
    ui.open()
end
dap.listeners.before.launch.dapui_config = function()
    ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    ui.close()
end
