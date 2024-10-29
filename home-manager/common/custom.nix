# TODO: Expose this as a home manager module with an option for path to the source to enable hot-reloading of the config.
{ pkgs, ... }:
let
    # My actual neovim package.
    myNvimPkg = (pkgs.callPackage ../../pkgs/my-nvim {}).package;

    myNvimPkgWrapper = pkgs.writeShellScriptBin "my-nvim" ''
        ${myNvimPkg}/bin/nvim "$@"
    '';

in
{
    # My custom neovim package installed as "my-nvim"
    home.packages = [
        myNvimPkgWrapper
    ];

    # The home manager module installed as "my-nvim-dev" (for now)
    imports = [
        ../../pkgs/my-nvim/home.nix
    ];

    programs.my-nvim.enable = true;
    programs.my-nvim.pathToMyNvimSource = /home/nigel/my-nixos-config/pkgs/my-nvim;
    # programs.my-nvim.appName = "custommynvim";
}
