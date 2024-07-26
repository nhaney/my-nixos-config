local function init(config)
    vim.print(vim.inspect(config))

    require 'my-nvim-config.keymaps'
    require 'my-nvim-config.options'
end

vim.print("hello there from custom plugin edited.")

return {
    init = init,
}
