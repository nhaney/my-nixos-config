{
  description = "NixOS and home-manager configurations for my machines.";

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

    # Nixvim input, used for configuring neovim.
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix input, used for styling desktop.
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    firefox-addons,
    nixvim,
    stylix,
  } @ inputs:
  let
    inherit (self) outputs;

    system = "x86_64-linux";

    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
  in
  {
    # My NixOS configurations.
    # Rebuild with sudo nixos-rebuild switch --flake .#desktop
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };

    # My standalone home-manager configurations. This is separate from my NixOS configuration to allow for running
    # home manager on machines that are not running NixOS.
    # To run: home-manager switch --flake .#your-username@your-hostname
    homeConfigurations = {
      "nigel@desktop" = home-manager.lib.homeManagerConfiguration {
        # Use the packages specified above for this home manager configuration.
        inherit pkgs;
        extraSpecialArgs = { inherit firefox-addons; inherit nixvim; inherit stylix; };
        
        # Home manager modules used.
        modules = [
          ./home-manager/common
          ./home-manager/desktop
        ];
      };
    };
  };
}
