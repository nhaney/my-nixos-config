{
  pkgs,
  config,
  lib,
  stylix,
  ...
}:
{
  stylix.targets.rofi.enable = true;

  # Uses stylix to theme rofi using rofi_theme.mustache template instead of its default behavior.
  #programs.rofi = {
  #  theme = config.lib.stylix.colors {
  #    template = builtins.readFile ./rofi_theme.mustache;
  #    extension = ".rasi";
  #  };
  #};
}
