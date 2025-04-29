M = {}

function M.setup(config)
    -- See https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md for more information on how to configure nixd.
    -- TODO: Configure home manager options as well.
    local capabilities = require('my-nvim-config.lsp').get_capabilities()
    require 'lspconfig'.nixd.setup {
        capabilities = capabilities,
        -- Semantic highlighting doesn't work well for nix. Treesitter grammar is better for now.
        on_init = function(client, _)
            client.server_capabilities.semanticTokensProvider = nil
        end,
        cmd = { "nixd" },
        handlers = {
            ["textDocument/definition"] = function(...)
                return nil
            end
        },
        settings = {
            nixpkgs = {
                -- TODO: Make this throw a better exception or just ignore this setting if the path is not set.
                -- We want this to be parameterized so we can choose the correct nixpkgs for the flake that
                -- the project is a part of.
                expr = "import (builtins.getFlake \"" .. config.nixPkgsFlakePath .. "\").inputs.nixpkgs",
            },
            formatting = {
                command = { "nixfmt" },
            },
        },
    }

    -- nixd doesn't always go to definition properly, so use nil_ls for this instead.
    require 'lspconfig'.nil_ls.setup { capabilities = capabilities,
        -- Semantic highlighting doesn't work well for nix. Treesitter grammar is better for now.
        on_init = function(client, _)
            client.server_capabilities.semanticTokensProvider = nil
        end,
    }
end

return M
