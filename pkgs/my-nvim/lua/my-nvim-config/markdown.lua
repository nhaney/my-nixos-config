require('render-markdown').setup({
    file_types = { "markdown", "Avante" },
})

-- An example nvim-lspconfig capabilities setting
local capabilities = require('my-nvim-config.lsp').get_capabilities()

require("lspconfig").markdown_oxide.setup({
    -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
    -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
    capabilities = vim.tbl_deep_extend(
        'force',
        capabilities,
        {
            workspace = {
                didChangeWatchedFiles = {
                    dynamicRegistration = true,
                },
            },
        }
    )
})
