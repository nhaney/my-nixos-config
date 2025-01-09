M = {}

function M.setup(config)
    -- Make sure to setup your API key in the environment. For example, ANTHROPIC_API_KEY=...
    -- Used for integrated AI chat and editing.
    require('avante_lib').load()
    require('avante').setup({
        -- Use <leader>ae to edit code block in case I forget.
        hints = { enabled = false },
    })

    -- disable copilot by default, enable it with :Copilot enable if I want it.
    vim.g.copilot_enabled = false
end

return M
