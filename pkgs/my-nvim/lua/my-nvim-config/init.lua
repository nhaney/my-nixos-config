local function init(config)
    vim.print(vim.inspect(config))
end

vim.print("hello there from custom plugin.")

return {
    init = init,
}
