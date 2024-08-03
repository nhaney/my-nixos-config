{ pkgs, config, ... }:
let
    # My actual neovim package.
    myNvim = pkgs.callPackage ../../pkgs/my-nvim {};
    my-nvim-wrapper = pkgs.writeShellScriptBin "my-nvim" ''
        ${myNvim}/bin/nvim "$@"
    '';

    # My dev neovim package with hot reloading.
    pathToMyNvimSource = "${config.home.homeDirectory}/my-nixos-config/pkgs/my-nvim";
    my-nvim-dev-wrapper = pkgs.writeShellScriptBin "my-nvim-dev" ''
        NVIM_APPNAME=my-nvim ${myNvim}/bin/nvim "$@"
    '';

in
{
  # My custom neovim package.
  home.packages = [
    my-nvim-wrapper
    my-nvim-dev-wrapper
  ];

  # Make a symlink that uses the custom neovim plugin defined in this flake as a normal nix config for
  # faster development iterations.
  home.file."${config.xdg.configHome}/my-nvim".source = config.lib.file.mkOutOfStoreSymlink pathToMyNvimSource;
}
