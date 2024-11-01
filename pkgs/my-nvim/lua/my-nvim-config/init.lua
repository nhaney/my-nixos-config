local function init(config)
    vim.print(vim.inspect(config))

    require 'my-nvim-config.keymap'
    require 'my-nvim-config.options'
    require 'my-nvim-config.search'
    require 'my-nvim-config.files'
    require 'my-nvim-config.lsp'
    require 'my-nvim-config.completion'

    if config.features.neovimDev.enable then
        require 'my-nvim-config.nvimdev'
    end
end

vim.print("hello there from custom plugin edited via symlink...")

return {
    init = init,
}
