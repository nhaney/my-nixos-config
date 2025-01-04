M = {}

function M.setup(config)
    local capabilities = require('my-nvim-config.lsp').get_capabilities()
    require 'lspconfig'.lua_ls.setup { capabilities = capabilities }
    require('lazydev').setup()
end

return M
