M = {}

function M.setup(config)
    require'lspconfig'.lua_ls.setup{}
    require('lazydev').setup()
end

return M
