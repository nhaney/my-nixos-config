M = {}

function M.setup(config)
    local capabilities = require('my-nvim-config.lsp').get_capabilities()

    vim.lsp.config("lua_ls", { capabilities = capabilities })
    vim.lsp.enable("lua_ls")

    require('lazydev').setup()
end

return M
