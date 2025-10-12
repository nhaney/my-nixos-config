{
  pkgs,
  lib,
  ...
}:

let
  modKey = "Mod4";
  termCmd = "${pkgs.alacritty}/bin/alacritty --command tmux";

  defaultConfig = builtins.readFile ./i3.config;
  defaultConfigLines = lib.strings.splitString "\n" defaultConfig;
in
{
  # Enable rofi. Used to run programs from i3.
  programs.rofi = {
    enable = true;
    terminal = termCmd;
  };

  # TODO: Add more to this. Potentially conditionally add things based on other config settings (e.g. Plasma desktop enabled).
  xdg.configFile."i3/config".text = lib.strings.concatLines (
    defaultConfigLines
    ++ [
      "bindsym ${modKey}+Return exec \"${termCmd}\""
      "bindsym ${modKey}+d exec --no-startup-id \"${pkgs.rofi}/bin/rofi -show drun\""
      "bindsym ${modKey}+period exec --no-startup-id \"${pkgs.rofimoji}/bin/rofimoji\""
      # Just randomize whatever is in ~/.wallpapers directory.
      "exec_always --no-startup-id \"${pkgs.feh}/bin/feh --bg-fill --randomize ~/.wallpapers/*\""
    ]
  );
}
