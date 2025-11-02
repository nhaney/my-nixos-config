# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  users.users.nigel = {
    isNormalUser = true;
    description = "Nigel Haney";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  networking.hostName = "archives";
  networking.networkmanager.enable = true;

  # Tailscale networking
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
    home-manager
    dig
    caddy
  ];

  system.stateVersion = "24.05";

  # Nix settings.
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Caddy webserver setup.

  services.caddy = {
    enable = true;

    virtualHosts = {
      "notes.archives.tail68797.ts.net" = {
        extraConfig = ''
          reverse_proxy localhost:3000
        '';
      };
    };
  };

  networking.firewall = {
    # Allow traffic to the webserver on 80/443 on tailscale interface.
    interfaces.tailscale0 = {
      allowedTCPPorts = [
        80
        443
      ];
    };
    # No public access. (doesn't work anyway because I have a Hetzner firewall here.)
    allowedTCPPorts = [ ];
  };

}
