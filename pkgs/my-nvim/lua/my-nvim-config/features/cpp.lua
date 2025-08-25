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

    require("cmake-tools").setup {
        cmake_generate_options = {
            -- Generates compile commands used by LSP.
            "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
            -- Options used by some of my projects for enabling tests in build
            -- TODO: Allow these options to be passed into config instead of just putting them here.
            "-DBUILD_TESTS=ON"
        },
        cmake_dap_configuration = {
            name = "cpp",
            type = "codelldb",
            request = "launch",
            stopOnEntry = false,
            runInTerminal = false,
            console = "integratedTerminal",
            -- Break on exception thrown.
            initCommands = { "breakpoint set -E c++" }
        },
    }
end

return M
