{ pkgs, ... }:

let
  ws1 = "1";
  ws2 = "2";
  ws3 = "3";
  ws4 = "4";
  ws5 = "5";
  ws6 = "6";
  ws7 = "7";
  ws8 = "8";
  ws9 = "9";

  opaqueWindows = [ "Rofi" "firefox" "i3lock" ];
in
{
  home.packages = with pkgs; [
    # Used for desktop background.
    feh
    # Used for cliboard.
    xclip
    # Used for lock screen
    i3lock
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
    backend = "glx";

    opacityRules = map (window: "100:class_g *?= '${window}'") opaqueWindows;

    settings = {
      corner-radius = 8;
      rounded-corners-exclude = [
        "class_i = 'polybar'"
      ];
      blur = {
        method = "dual_kawase";
	strength = 3;
	background = true;
	frame = true;
      };
    };
  };

  # Put my desktop background in a common place.
  home.file.".background.jpg".source = ./ultrawide_darksouls_wallpaper.jpg;

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;

      config = rec {
        modifier = "Mod4";

        fonts = {
          names = [ "FiraCode" ];
          style = "Bold";
          size = 10.0;
        };

        bars = [ ];

        #window = {
        #  border = 0;
        #  hideEdgeBorders = "both";
        #};

        gaps = {
          inner = 10;
          outer = 5;
        };


        keybindings = {
          # General control

          ## Workspaces
          "${modifier}+1" = "workspace number ${ws1}";
          "${modifier}+2" = "workspace number ${ws2}";
          "${modifier}+3" = "workspace number ${ws3}";
          "${modifier}+4" = "workspace number ${ws4}";
          "${modifier}+5" = "workspace number ${ws5}";
          "${modifier}+6" = "workspace number ${ws6}";
          "${modifier}+7" = "workspace number ${ws7}";
          "${modifier}+8" = "workspace number ${ws8}";
          "${modifier}+9" = "workspace number ${ws9}";

          ## Focus movement
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+h" = "focus left";
          "${modifier}+l" = "focus right";

          "${modifier}+Down" = "focus down";
          "${modifier}+Up" = "focus up";
          "${modifier}+Left" = "focus left";
          "${modifier}+Right" = "focus right";

          ## Window manipulation

          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+l" = "move right";

          "${modifier}+Shift+Down" = "move down";
          "${modifier}+Shift+Up" = "move up";
          "${modifier}+Shift+Left" = "move left";
          "${modifier}+Shift+Right" = "move right";

          "${modifier}+Shift+1" = "move container to workspace number ${ws1}";
          "${modifier}+Shift+2" = "move container to workspace number ${ws2}";
          "${modifier}+Shift+3" = "move container to workspace number ${ws3}";
          "${modifier}+Shift+4" = "move container to workspace number ${ws4}";
          "${modifier}+Shift+5" = "move container to workspace number ${ws5}";
          "${modifier}+Shift+6" = "move container to workspace number ${ws6}";
          "${modifier}+Shift+7" = "move container to workspace number ${ws7}";
          "${modifier}+Shift+8" = "move container to workspace number ${ws8}";
          "${modifier}+Shift+9" = "move container to workspace number ${ws9}";

          "${modifier}+a+Shift+'" = "split h";
          "${modifier}+a+Shift+5" = "split v";

          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+r" = "mode resize";

          "${modifier}+shift+q" = "kill";

          ## i3 commands
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+r" = "restart";
          "${modifier}+Shift+e" = "exit";

          # Programs

          ## Alacritty - terminal
          "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";

          ## Rofi - application launcher
          "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";

          ## Flameshot - screenshot tool
          "${modifier}+shift+s" = "exec ${pkgs.flameshot}/bin/flameshot gui -c";
          "${modifier}+shift+a" = "exec ${pkgs.flameshot}/bin/flameshot gui";

          ## i3lock - lock screen
          "${modifier}+shift+x" = "exec ${pkgs.i3lock}/bin/i3lock";
        };

        # Assign specific windows to work spaces. Might use this in the future.
        assigns = {
          # ${workspace.steam} = [{ class = "^Steam$"; }];
        };

        modes.resize = {
          "h" = "resize grow width 10 px or 10 ppt";
          "j" = "resize shrink height 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize shrink width 10 px or 10 ppt";
          "Escape" = "mode \"default\"";
          "Enter" = "mode \"default\"";
          "${modifier}+r" = "mode \"default\"";
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
        ];
      };
    };
  };
}