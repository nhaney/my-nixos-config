M = {}

function M.setup(config)
    -- vim.print(vim.inspect(config))
    require 'my-nvim-config.keymap'
    require 'my-nvim-config.options'
    require 'my-nvim-config.search'
    require 'my-nvim-config.files'
    require 'my-nvim-config.lsp'.setup()
    require 'my-nvim-config.completion'.setup()
    require 'my-nvim-config.format'
    require 'my-nvim-config.markdown'
    require 'my-nvim-config.status'.setup()

    if config.features.neovimDev.enable then
        require 'my-nvim-config.features.neovim-dev'.setup(config.features.neovimDev)
    end

    if config.features.nix.enable then
        require 'my-nvim-config.features.nix'.setup(config.features.nix)
    end

    if config.features.dotnet.enable then
        require 'my-nvim-config.features.dotnet'.setup(config.features.dotnet)
    end

    if config.features.python.enable then
        require 'my-nvim-config.features.python'.setup(config.features.python)
    end

    if config.features.llm.enable then
        require 'my-nvim-config.llm'.setup()
    end

    require 'my-nvim-config.theme'
end

return M
