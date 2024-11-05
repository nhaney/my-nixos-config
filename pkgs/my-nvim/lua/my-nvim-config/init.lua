M = {}

function M.setup(config)
    -- vim.print(vim.inspect(config))

    require 'my-nvim-config.keymap'
    require 'my-nvim-config.options'
    require 'my-nvim-config.search'
    require 'my-nvim-config.files'
    require 'my-nvim-config.lsp'
    require 'my-nvim-config.completion'
    require 'my-nvim-config.format'

    if config.features.neovimDev.enable then
        require 'my-nvim-config.features.neovim-dev'.setup(config.features.neovimDev)
    end

    if config.features.nix.enable then
        require 'my-nvim-config.features.nix'.setup(config.features.nix)
    end
end

vim.print("hello there from custom plugin edited via symlink...")

return M
