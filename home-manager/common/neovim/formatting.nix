{
    programs.nixvim = {
        plugins = {
            conform-nvim = {
                enable = true;
                formattersByFt = {
                    _ = [ "trim_whitespace" ];
                };
                extraOptions = {
                    format_on_save = {
                        lsp_fallback = true;
                        timeout_ms = 500;
                    };
                };
            };
        };

        # autoCmd = [
        #     {
        #         event = ["BufWritePre"];
        #         pattern = ["*"];
        #         callback = {
        #             __raw = "function(args) require(\"conform\").format({bufnr = args.buf}) end";
        #         };
        #     }
        # ];
    };
}

