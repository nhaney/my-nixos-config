{ pkgs, ... }:

let
  modifier = "Mod4";
  workspace = {
    dev = "dev";
    extra = "extra";
  };

  opaqueWindows = [ "Rofi" "firefox" ];
in
{
  home.packages = with pkgs; [
    # Used for desktop background.
    feh
    # Used for cliboard.
    xclip
    # Dependency of picom.
    pcre.dev
  ];

  # Enable rofi. Used to run programs from i3.
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ./theme.rasi;
  };

  # Enable and run flameshot. Used for screenshotting.
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        uiColor = "#FFFFFF";
        showHelp = false;
      };
    };
  };

  # Enable and run polybar. This is the status bar in the xsession.
  services.polybar = {
    enable = true;
    config = ./polybar_config.ini;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      pulseSupport = true;
    };
    script = "polybar &";
    extraConfig = (builtins.readFile ./polybar_modules.ini);
  };

  # Enable and run picom window compositor for things like transparant windows and border rounding.
  services.picom = {
    enable = true;

    activeOpacity = 1.0;
    inactiveOpacity = 0.95;
    fade = true;

    opacityRules = map (window: "100:class_g *?= '${window}'") opaqueWindows;

    settings = {
      corner-radius = 8;
      rounded-corners-exclude = [
        "class_i = 'polybar'"
      ];
    };
  };

  # Put my desktop background in a common place.
  home.file.".background.jpg".source = ./ultrawide_darksouls_wallpaper.jpg;

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        inherit modifier;

        bars = [ ];

        window = {
          border = 0;
          hideEdgeBorders = "both";
        };

        gaps = {
          inner = 10;
          outer = 5;
        };

        keybindings = {
          # Alacritty terminal
          "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";

          # Rofi
          "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";

          # Screenshot
          "${modifier}+shift+s" = "exec ${pkgs.flameshot}/bin/flameshot gui -c";
          "${modifier}+shift+a" = "exec ${pkgs.flameshot}/bin/flameshot gui";

          # Movement
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+h" = "focus left";
          "${modifier}+l" = "focus right";

          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Left" = "focus left";
          "${modifier}+Right" = "focus right";

          # Workspaces
          # "${modifier}+space" = "workspace ${workspace.terminal}";
          # "${modifier}+m" = "workspace ${workspace.code}";
          # "${modifier}+comma" = "workspace ${workspace.browser}";
          # "${modifier}+period" = "workspace ${workspace.bitwarden}";
          # "${modifier}+slash" = "workspace ${workspace.spotify}";
          # "${modifier}+u" = "workspace ${workspace.discord}";
          # "${modifier}+i" = "workspace ${workspace.signal}";
          # "${modifier}+o" = "workspace ${workspace.ledger}";
          # "${modifier}+p" = "workspace ${workspace.extra}";
          # "${modifier}+bracketright" = "workspace ${workspace.steam}";
          # "${modifier}+backslash" = "workspace ${workspace.steam-app}";

          # Misc
          "${modifier}+shift+q" = "kill";
          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+z" = "split h";
          "${modifier}+x" = "split v";
          "${modifier}+r" = "mode resize";
        };

	# Assign specific windows to work spaces.
        assigns = {
          # ${workspace.steam} = [{ class = "^Steam$"; }];
        };

        modes.resize = {
          "h" = "resize grow width 10 px or 10 ppt";
          "j" = "resize shrink height 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize shrink width 10 px or 10 ppt";
          "Escape" = "mode default";
        };

        startup = [
          {
            command = "${pkgs.feh}/bin/feh --bg-fill ~/.background.jpg";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart polybar.service";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.alacritty}/bin/alacritty";
            always = false;
            notification = false;
          }
        ];
      };
    };
  };
}
