{ pkgs, ... }:
# Various CLI tools that I use and their configs.
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
}
