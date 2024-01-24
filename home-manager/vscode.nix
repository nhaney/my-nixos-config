# Configures VSCode + extensions.
{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
      ionide.ionide-fsharp
      bbenoist.nix
      ms-python.python
    ];
  };
}
