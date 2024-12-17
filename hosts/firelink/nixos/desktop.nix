# System level configuration for setting up the desktop environment that every user in the host will use.
{
  pkgs,
  lib,
  config,
  ...
}:
{
  # Configure GUI desktop environment (i3). Actual i3 customization is not done here and instead is done in the user profile/home manager.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    displayManager = {
      defaultSession = "none+i3";
      autoLogin.enable = true;
      autoLogin.user = "nigel";
      # Set up based on autorandr.
      setupCommands = ''
        ${pkgs.autorandr}/bin/autorandr --change
      '';
    };

    windowManager.i3 = {
      enable = true;
      #package = pkgs.i3-gaps;
      #extraPackages = with pkgs; [
      #  dmenu
      #  i3status
      #  i3lock
      #  i3blocks
      #];
    };

    desktopManager = {
      xterm.enable = false;
    };
  };

  services.autorandr = {
    enable = true;
    matchEdid = true;
    profiles = {
      # Odyssey G9 Full screen.
      "default" = {
        fingerprint = {
          DP-0 = "00ffffffffffff004c2d537000000000011e0104b57722783ac725b14b46a8260e5054bfef80714f810081c08180a9c0b3009500d1c01a6800a0f0381f4030203a00a9504100001a000000fd0832f01e66c2000a202020202020000000fc004c433439473935540a20202020000000ff004831414b3530303030300a20200247020322f044105a3f5c2309070783010000e305c000e60605018b7312e5018b849001565e00a0a0a0295030203500a9504100001a584d00b8a1381440f82c4500a9504100001e74d600a0f038404030203a00a9504100001a6fc200a0a0a0555030203500a9504100001a0000000000000000000000000000000000000000008270127900000301649cf50288ff133f017f801f009f052e00200007002f790108ff139f002f801f009f0553000200090033b70008ff139f002f801f009f05280002000900e36e0108ff094f0007801f009f052a002000070090c70108ff0e9f002f801f0037048600020009000000000000000000000000000000000000001d90";
        };
        config = {
          DP-0 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "5120x1440";
            rate = "240.00";
          };
        };
      };
      # Odyssey G9 when in PIP mode.
      "pip" = {
        fingerprint = {
          DP-0 = "00ffffffffffff004c2d537000000000011e0104b57722783ac725b14b46a8260e5054bfef80714f810081c08180a9c0b3009500d1c0565e00a0a0a0295030203500a9504100001a000000fd0032781eb732000a202020202020000000fc004c433439473935540a20202020000000ff004831414b3530303030300a202001a8020313f146905a591f04132309070783010000023a801871382d40582c4500a9504100001e584d00b8a1381440f82c4500a9504100001e6fc200a0a0a0555030203500a9504100001a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000095";
        };
        config = {
          DP-0 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "2560x1440";
            # Apparently the g9 can go to 230hz in pip mode!
            rate = "230.0";
          };
        };
      };
    };
    hooks = {
      postswitch = {
        "notify-i3" = "${pkgs.i3}/bin/i3-msg restart";
      };
    };
  };

  # TODO: Fix this so it works. Currently it is not.
  services.udev.extraRules = ''ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"'';

  # Run autorandr on login instead of just sleep like it is set up now.
  systemd.user.services.autorandr-login = {
    description = "autorandr start on login";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.autorandr}/bin/autorandr \
          --batch \
          --change \
          --default ${config.services.autorandr.defaultTarget} \
          ${lib.optionalString config.services.autorandr.ignoreLid "--ignore-lid"} \
          ${lib.optionalString config.services.autorandr.matchEdid "--match-edid"}
      '';
    };
  };
}
