{ pkgs, ...}:
{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./vscode.nix
    ./wm
    ./theme
  ];

}
