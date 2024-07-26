local function init(config)
    vim.print(vim.inspect(config))
end

vim.print("hello there from custom plugin edited.")

return {
    init = init,
}
