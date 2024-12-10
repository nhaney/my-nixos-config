{
  description = "My collection of my NixOS modules and configurations, home-manager modules and configurations, and helper functions.";

  inputs = {
    # Nixpkgs input, define version of nixpkgs to use.
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # Home manager input, define which version of home manager to use and which nixpkgs it should use.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Firefox addons input, define which version of the firefox addons repo to use.
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix input, used for styling desktop consitently across apps.
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # SSBM support.
    slippi = {
      url = "github:lytedev/slippi-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      firefox-addons,
      stylix,
      slippi,
    }@inputs:
    let
      inherit (self) outputs;

      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      # My NixOS configurations.
      # Rebuild with sudo nixos-rebuild switch --flake .#<name of host>
      nixosConfigurations = {
        firelink = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
            inherit slippi;
          };
          modules = [
            ./hosts/firelink/nixos
          ];
        };

        catacombs = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/catacombs/nixos
          ];
        };

        archives = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/archives/nixos
          ];
        };
      };

      # My standalone home-manager configurations. This is separate from my NixOS configuration to allow for running
      # home manager on machines that are not running NixOS.
      # To run: home-manager switch --flake .#your-username@your-hostname
      homeConfigurations = {
        "nigel@firelink" = home-manager.lib.homeManagerConfiguration {
          # Use the packages specified above for this home manager configuration.
          inherit pkgs;
          extraSpecialArgs = {
            inherit firefox-addons;
            inherit stylix;
            inherit slippi;
          };

          # Home manager modules used.
          modules = [
            ./hosts/firelink/home
          ];
        };

        "nigel@catacombs" = home-manager.lib.homeManagerConfiguration {
          # Use the packages specified above for this home manager configuration.
          inherit pkgs;
          extraSpecialArgs = {
            inherit firefox-addons;
            inherit stylix;
          };

          # Home manager modules used.
          modules = [
            ./hosts/catacombs/home
          ];
        };

        "nigel@archives" = home-manager.lib.homeManagerConfiguration {
          # Use the packages specified above for this home manager configuration.
          inherit pkgs;

          # Home manager modules used.
          modules = [
            ./hosts/archives/home
          ];
        };
      };

      lib = {
        # Function to create a custom neovim derivation for per-project configs.
        mkMyNeovim =
          { myNvimConfig }:
          (pkgs.callPackage ./pkgs/my-nvim/default.nix {
            inherit myNvimConfig;
          }).package;
      };
    };
}
