M = {}

function M.setup(config)
    -- See https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md for more information on how to configure nixd.
    require 'lspconfig'.nixd.setup {
        cmd = { "nixd" },
        settings = {
            nixpkgs = {
                -- We want this to be parameterized so we can choose the correct nixpkgs for the flake that
                -- the project is a part of.
                expr = "import (builtins.getFlake \"" .. config.nixPkgsFlakePath .. "\").inputs.nixpkgs",
            },
            formatting = {
                command = { "nixfmt" },
            },
        },
    }

    -- nixd doesn't always go to definition properly.
    require 'lspconfig'.nil_ls.setup {}
end

return M
