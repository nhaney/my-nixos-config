M = {}

function M.setup()
    -- LSP configuration. Using ruff for linting/formatting and basedpyright for typechecking.
    local capabilities = require('my-nvim-config.lsp').get_capabilities()
    vim.lsp.config("ruff", { capabilities = capabilities })
    vim.lsp.enable("ruff")

    vim.lsp.config("basedpyright", { capabilities = capabilities })
    vim.lsp.enable("basedpyright")

    local pythonPath = vim.fn.exepath('python')

    -- This overrides the defaults of dap-python with my custom debugpy executable that is compatible with nix.
    local dap = require('dap')
    dap.adapters.python = {
        type = 'executable',
        command = 'my-debugpy',
    }

    dap.configurations.python = {
        {
            type = 'python',
            request = 'launch',
            name = 'file',
            program = '${file}',
            justMyCode = false,
            pythonPath = pythonPath,
        },
        {
            type = 'python',
            request = 'launch',
            name = 'file:args',
            program = '${file}',
            args = function()
                local args_string = vim.fn.input('Arguments: ')
                local utils = require("dap.utils")
                return utils.splitstr(args_string)
            end,
            justMyCode = false,
            pythonPath = pythonPath,
        },
        {
            type = 'python',
            request = 'launch',
            name = 'file:doctest',
            module = 'doctest',
            args = { "${file}" },
            noDebug = true,
            pythonPath = pythonPath,
        },
        {
            type = 'python',
            request = 'launch',
            name = 'file:pytest',
            module = 'pytest',
            args = { "${file}" },
            pythonPath = pythonPath,
            justMyCode = false,
        },
    }

    -- Keymaps for python specific running configs. Currently dap-python individual test run is not working.
    -- vim.keymap.set('n', '<Leader>dt', function() require('dap-python').test_method() end)
    -- vim.keymap.set('n', '<Leader>dc', function() require('dap-python').test_class() end)
    -- vim.keymap.set('n', '<Leader>ds', function() require('dap-python').debug_selection() end)
end

return M
