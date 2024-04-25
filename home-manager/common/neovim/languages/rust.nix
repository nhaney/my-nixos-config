{ pkgs, ... }:
{
    home.packages = with pkgs; [ cargo rustc ];

    programs.nixvim.plugins = {
        lsp.servers.rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
        };
    };
}
