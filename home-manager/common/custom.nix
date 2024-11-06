# TODO: Expose this as a home manager module with an option for path to the source to enable hot-reloading of the config.
{ pkgs, ... }:
{
  # The home manager module installed as "my-nvim-dev" (for now)
  imports = [
    ../../pkgs/my-nvim/home.nix
  ];

  programs.my-nvim.enable = true;
  programs.my-nvim.pathToMyNvimSource = /home/nigel/my-nixos-config/pkgs/my-nvim;
  # programs.my-nvim.appName = "custommynvim";
}
