# System level configuration for setting up the desktop environment that every user in the host will use.
{
  pkgs,
  lib,
  fakwin,
  ...
}:
{
  # Configure KDE plasma with i3.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    windowManager.i3 = {
      enable = true;
    };
  };

  services.desktopManager.plasma6 = {
    enable = true;
  };

  services.displayManager = {
    defaultSession = "plasmax11";
    sddm.enable = true;
  };

  systemd.user.services.plasma-i3wm = {
    wantedBy = [ "plasma-workspace-x11.target" ];
    description = "Launch Plasma with i3wm.";
    environment = lib.mkForce { };
    serviceConfig = {
      ExecStart = "${pkgs.i3}/bin/i3";
      Restart = "on-failure";
    };
  };

  systemd.user.services.plasma-workspace-x11.after = [ "plasma-i3wm.target" ];
  systemd.user.services.plasma-kwin_x11.enable = false;

  imports = [
    fakwin.nixosModules.default
  ];

  services.fakwin.enable = true;
}
