{ pkgs, ... }:
{
  home.packages = [
    pkgs.unzip
    pkgs.jq
    # For using wine and running windows applications on linux.
    pkgs.wineWowPackages.stable
    pkgs.winetricks
  ];
}
