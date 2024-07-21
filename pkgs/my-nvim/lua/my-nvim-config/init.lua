local function init(greeting)
    vim.print("'".. greeting .. "' from custom plugin.")
end

vim.print("hello there from custom plugin.")

return {
    init = init,
}
