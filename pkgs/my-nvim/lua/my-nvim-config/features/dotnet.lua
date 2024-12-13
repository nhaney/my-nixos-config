M = {}

function M.setup(config)
    require('roslyn').setup {
        exe = 'Microsoft.CodeAnalysis.LanguageServer',
        args = {
            "--logLevel=Debug", "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path())
        },
    }
end

return M
