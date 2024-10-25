# TODO: Expose this as a home manager module with an option for path to the source to enable hot-reloading of the config.
{ pkgs, config, ... }:
let
    # My actual neovim package.
    myNvim = (pkgs.callPackage ../../pkgs/my-nvim {}).package;
    my-nvim-wrapper = pkgs.writeShellScriptBin "my-nvim" ''
        ${myNvim}/bin/nvim "$@"
    '';

    # My dev neovim package with hot reloading.
    pathToMyNvimSource = "${config.home.homeDirectory}/my-nixos-config/pkgs/my-nvim";

    # By doing this, we force neovim to use the my-nvim config that is later symlinked to 
    # the files in this repo. This allows for hot-reloading of the config without a nix rebuild.
    my-nvim-dev-wrapper = pkgs.writeShellScriptBin "my-nvim-dev" ''
        NVIM_APPNAME=my-nvim ${pkgs.neovim-unwrapped}/bin/nvim "$@"
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
