{
    programs.nixvim.plugins = {
        lsp = {
            servers = {
                # Pyright is the main LSP in use.
                pyright = {
                    enable = true;
                    extraOptions = {
                        settings = {
                            pyright = {
                                # Using Ruff's import organizer
                                disableOrganizeImports = true;
                            };
                            python = {
                                analysis = {
                                    # Ignore all files for analysis to exclusively use Ruff for linting.
                                    ignore.__raw = ''{ '*' }'';
                                };
                            };
                        };
                    };
                };

                # Ruff is used for linting and formatting.
                ruff-lsp = {
                    enable = true;
                    extraOptions = {
                        # Disable hover in favor of pyright.
                        # Organize imports via code action on save. TODO: make this not be a wait.
                        on_attach.__raw = ''
                            function(client, bufnr)
                                if client.name == "ruff_lsp" then
                                    client.server_capabilities.hoverProvider = false
                                end

                                vim.api.nvim_create_autocmd("BufWritePre", {
                                    buffer = bufnr,
                                    callback = function()
                                        vim.lsp.buf.code_action({
                                            context = { only = { "source.organizeImports" } },
                                            apply = true,
                                        })
                                        vim.wait(100)
                                    end,
                                })
                            end
                        '';
                    };
                };
            };
        };

        # Not using these, but this could be an example for other languages.
        # conform-nvim.formattersByFt = {
        #     python = [ "isort" "black" ];
        # };
    };
}
