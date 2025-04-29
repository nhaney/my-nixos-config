{
  imports = [
    ./configuration.nix
    ./nvidia-gpu.nix
    ./desktop.nix
    ./postgres.nix
    ../../../modules/nixos/silverbullet.nix
    ../../../modules/nixos/gaming.nix
  ];
}
