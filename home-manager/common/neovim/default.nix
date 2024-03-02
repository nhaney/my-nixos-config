{ nixvim, ... }:
{
    # Import the base nixvim home manager module.
    imports = [
        nixvim.homeManagerModules.nixvim
        ./theme.nix
        ./lualine.nix
        ./keymap.nix
        ./options.nix
        ./lsp.nix
        ./languages
        ./cmp.nix
        ./telescope.nix
    ];

    programs.nixvim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
    };
}
