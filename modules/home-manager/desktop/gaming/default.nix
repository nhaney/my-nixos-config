{ pkgs, ... }:
{
  imports = [
    ./rpcs3.nix
    ./melee.nix
    ./wine.nix
  ];
}
