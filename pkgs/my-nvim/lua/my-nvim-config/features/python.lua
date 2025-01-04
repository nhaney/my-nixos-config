M = {}

function M.setup(config)
    local capabilities = require('my-nvim-config.lsp').get_capabilities()
    require 'lspconfig'.ruff.setup { capabilities = capabilities }
    require 'lspconfig'.basedpyright.setup { capabilities = capabilities }
end

return M
