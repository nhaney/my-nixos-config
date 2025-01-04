M = {}

function M.setup(config)
    -- Make sure to setup your API key in the environment. For example, ANTHROPIC_API_KEY=...
    -- Used for integrated AI chat and editing.
    require('avante_lib').load()
    require('avante').setup()

    -- disable copilot by default, enable it with <leader>+ac
end

return M
