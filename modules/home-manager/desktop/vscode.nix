# Configures VSCode + extensions.
{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    # Only allow extensions to be modified by nix.
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      yzhang.markdown-all-in-one
      ionide.ionide-fsharp
      bbenoist.nix
      ms-python.python
    ];
    userSettings = {
      "vim.useSystemClipboard" = true;
      "nix.editor.tabSize" = 2;
    };
  };
}
