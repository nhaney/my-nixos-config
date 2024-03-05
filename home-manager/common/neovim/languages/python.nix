{
    programs.nixvim.plugins = {
        lsp.servers = {
            pyright.enable = true;
        };

        conform-nvim.formattersByFt = {
            python = [ "isort" "black" ];
        };
    };
}
