M = {}

function M.setup()
    -- Configure bufferline
    vim.opt.termguicolors = true
    require("bufferline").setup {}
end

return M
