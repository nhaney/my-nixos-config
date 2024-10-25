local function init(config)
    vim.print(vim.inspect(config))

    require 'my-nvim-config.keymaps'
    require 'my-nvim-config.options'

    if config.neovimDevSupport then
        require 'my-nvim-config.nvimdev'
    end
end

vim.print("hello there from custom plugin edited via symlink")

return {
    init = init,
}
