{ pkgs, config, ... }:
let
  # Needed because of name conflict
  myconfig = config;
in
{
  xsession.windowManager.i3 = {
    package = pkgs.i3-gaps;
    config = {
      fonts = {
        names = [ config.stylix.fonts.monospace.name ];
        # Need to do this to convert to float?
        size = myconfig.stylix.fonts.sizes.desktop + 0.0;
      };

      bars = [ ];

      window = {
        border = 0;
        hideEdgeBorders = "both";
        # titlebar = false;
      };

      gaps = {
        inner = 10;
        outer = 5;
      };
    };
  };
}
