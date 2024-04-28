# Enables picom service which is a window compositor for things like transparant windows and blurring.
{ pkgs, ... }:
let
  opaqueWindows = [ "Rofi" "firefox" "i3lock" ];
in
{
  services.picom = {
    enable = true;

    activeOpacity = 1.0;
    inactiveOpacity = 0.90;
    fade = false;
    backend = "glx";

    opacityRules = map (window: "100:class_g *?= '${window}'") opaqueWindows;

    settings = {
      # Set below for rounded corners.
      # corner-radius = 8;
      # rounded-corners-exclude = [
      #   "class_i = 'polybar'"
      # ];
      blur = {
        method = "dual_kawase";
        strength = 3;
        background = true;
        frame = true;
      };
      unredir-if-possible = true;
    };
  };
}
