{ nixvim, ... }:
{
    # Import the base nixvim home manager module.
    imports = [
        nixvim.homeManagerModules.nixvim
        ./theme.nix
        ./lualine.nix
        ./options.nix
        ./lsp.nix
        ./languages
    ];

    programs.nixvim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
    };
}
