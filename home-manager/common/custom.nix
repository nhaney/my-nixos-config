{ pkgs, config, ... }:
let
    pathToMyNvim = "${config.home.homeDirectory}/my-nixos-config/pkgs/my-nvim";
    my-nvim-wrapper = pkgs.writeShellScriptBin "my-nvim" ''
        NVIM_APPNAME=my-nvim ${pkgs.neovim}/bin/nvim
    '';
in
{
  # My custom neovim package.
  home.packages = [
    my-nvim-wrapper
  ];

  home.file."${config.xdg.configHome}/my-nvim".source = config.lib.file.mkOutOfStoreSymlink pathToMyNvim;
}
