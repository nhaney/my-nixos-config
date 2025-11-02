{
  imports = [
    ../../../pkgs/my-nvim/home.nix
  ];

  programs.my-nvim = {
    enable = true;
    defaultEditor = true;
    pathToMyNvimSource = /home/nigel/my-nixos-config/pkgs/my-nvim;
    config.features.neovimDev.enable = true;
  };
}
