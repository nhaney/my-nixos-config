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
    restic
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
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
      hash = "sha256-dnhEjopeA0UiI+XVYHYpsjcEI6Y1Hacbi28hVKYQURg=";
    };

    virtualHosts = {
      "notes.nigelhaney.com" = {
        extraConfig = ''
          reverse_proxy http://localhost:3000
          tls {
            dns cloudflare {env.CF_API_TOKEN}
          }
        '';
      };

      "budget.nigelhaney.com" = {
        extraConfig = ''
          reverse_proxy http://localhost:3001
          tls {
            dns cloudflare {env.CF_API_TOKEN}
          }
        '';
      };
    };

    # Secrets for caddy. This needs to be manually generated on the host.
    # Make sure the caddy user has permission to read this file.
    # TODO: Migrate to sops-nix.
    environmentFile = "/etc/secrets/caddy.env";
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

  # Actual server.
  services.actual = {
    enable = true;
    settings = {
      port = 3001;
      dataDir = "/var/lib/actual";
    };
  };

  # Backups for self-hosted services (Restic + Backblaze).
  services.restic = {
    backups.services = {
      paths = [
        "/var/lib/silverbullet"
        "/var/lib/private/actual"
      ];

      repository = "s3:s3.us-west-004.backblazeb2.com/nigel-service-backup";

      # TODO: Hook this up w/ nix secret management instead of manually generating it.
      passwordFile = "/etc/secrets/restic.pass";

      # This needs to contain (some may not be needed):
      # AWS_DEFAULT_REGION
      # AWS_ACCESS_KEY_ID
      # AWS_SECRET_ACCESS_KEY
      # AWS_ENDPOINT
      # RESTIC_REPOSITORY
      # RESTIC_PASSWORD_FILE
      environmentFile = "/etc/secrets/restic.env";

      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };

      pruneOpts = [
        # Keep daily for the last week.
        "--keep-daily 7"
        # Keey 1 snapshot per week for the last 4 weeks.
        "--keep-weekly 4"
        # Keep 1 snapshot per month for the last 6 months.
        "--keep-monthly 6"
      ];
    };
  };

  # enable swap, only 2G ram on this VPS so this is helpful.
  swapDevices = [
    {
      device = "/swapfile";
      size = 2048;
    }
  ];
}
