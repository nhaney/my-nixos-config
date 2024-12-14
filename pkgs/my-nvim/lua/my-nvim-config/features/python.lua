M = {}

function M.setup(config)
    require 'lspconfig'.ruff.setup {}
    require 'lspconfig'.basedpyright.setup {}
end

return M
