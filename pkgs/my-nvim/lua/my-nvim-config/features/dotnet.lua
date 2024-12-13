M = {}

function M.setup(config)
    require('roslyn').setup {
        -- exe = 'Microsoft.CodeAnalysis.LanguageServer',
    }
end

return M
