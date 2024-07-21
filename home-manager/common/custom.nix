{ pkgs, ... }:
let
    my-nvim = pkgs.callPackage ../../pkgs/my-nvim { };
    my-nvim-wrapper = pkgs.writeShellScriptBin "my-nvim" ''
        ${my-nvim}/bin/nvim
    '';
in
{
  # My custom neovim package.
  home.packages = [
    my-nvim-wrapper
  ];
}
