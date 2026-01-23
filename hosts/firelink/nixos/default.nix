{
  imports = [
    ./configuration.nix
    ./nvidia-gpu.nix
    ./desktop.nix
    ../../../modules/nixos/silverbullet.nix
    ../../../modules/nixos/cli.nix
    ../../../modules/nixos/gaming.nix
  ];
}
