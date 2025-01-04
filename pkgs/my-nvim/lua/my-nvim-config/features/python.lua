M = {}

function M.setup()
    -- LSP configuration. Using ruff for linting/formatting and basedpyright for typechecking.
    local capabilities = require('my-nvim-config.lsp').get_capabilities()
    require 'lspconfig'.ruff.setup { capabilities = capabilities }
    require 'lspconfig'.basedpyright.setup { capabilities = capabilities }

    -- DAP configuration. Using dap-python with overrides for debugging.

    require('dap-python').setup()

    -- Launch python from the venv/dev shell for this to work.
    require('dap-python').resolve_python = function()
        return vim.fn.exepath('python')
    end

    -- Default to using pytest.
    require('dap-python').test_runner = 'pytest'

    -- This overrides the default settings of dap-python.
    local dap = require('dap')
    dap.adapters.python = function(cb, config)
        if config.request == 'attach' then
            ---@diagnostic disable-next-line: undefined-field
            local port = (config.connect or config).port
            ---@diagnostic disable-next-line: undefined-field
            local host = (config.connect or config).host or '127.0.0.1'
            cb({
                type = 'server',
                port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                host = host,
                options = {
                    source_filetype = 'python',
                },
            })
        else
            cb({
                type = 'executable',
                -- Will this work? Does debugpy nix package launch the adapter?
                command = 'debugpy',
                -- args = { '-m', 'debugpy.adapter' },
                options = {
                    source_filetype = 'python',
                },
            })
        end
    end

    dap.configurations.python = {
        {
            type = 'python',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            pythonPath = function()
                -- Uses the current python3. This means neovim needs to be launched in venv or dev shell with proper python for project.
                return vim.fn.exepath('python')
            end,
        },
    }
end

return M
