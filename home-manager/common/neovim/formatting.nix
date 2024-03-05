{
    programs.nixvim = {
        plugins = {
            conform-nvim = {
                enable = true;
                formattersByFt = {
                    _ = [ "trim_whitespace" ];
                };
            };
        };

        autoCmd = [
            {
                event = ["BufWritePre"];
                pattern = ["*"];
                callback = {
                    __raw = "function(args) require(\"conform\").format({bufnr = args.buf}) end";
                };
            }
        ];
    };
}

