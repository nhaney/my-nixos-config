{
  imports = [
    ../../pkgs/my-nvim/home.nix
  ];

  programs.my-nvim.enable = true;
  programs.my-nvim.pathToMyNvimSource = /home/nigel/my-nixos-config/pkgs/my-nvim;
}
