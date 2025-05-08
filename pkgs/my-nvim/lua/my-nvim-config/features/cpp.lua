M = {}

function M.setup()
    -- Language server.
    -- TODO: Figure out if anything needs to be passed to clangd or not.
    vim.lsp.enable('clangd')
    vim.lsp.config('clangd', {
        cmd = { 'clangd', '--clang-tidy' }
    })

    local dap = require('dap')

    dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
            command = "codelldb",
            args = { "--port", "${port}" },
        }
    };

    dap.configurations.cpp = {
        {
            name = 'Launch file',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},
        },
    };
end

return M
