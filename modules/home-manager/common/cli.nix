# Various CLI tools that I use and their configs.
{ pkgs, ... }:
{
  programs.fzf.enable = true;

  programs.bottom.enable = true;

  programs.git = {
    enable = true;
    delta.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  home.packages = [
    pkgs.unzip
    pkgs.jq
    # For using wine and running windows applications on linux.
    pkgs.wineWowPackages.stable
    pkgs.winetricks
  ];
}
