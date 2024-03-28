{ pkgs, ... }:
{
    home.packages = with pkgs; [ fantomas fsautocomplete ];

    # programs.nixvim.plugins.lsp.servers = {
    #     fsautocomplete.enable = true;
    # };

    programs.nixvim.extraPlugins = [ pkgs.vimPlugins.Ionide-vim ];
}
