local function init()
    vim.print("hello there from custom plugin.")
end

vim.print("hello there from custom plugin.")

return {
    init = init,
}
