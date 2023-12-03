{
  description = "NixOS and home-manager configurations for my machines.";

  inputs = {
    # Nixpkgs input, define version of nixpkgs to use.
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-23.05";
    };
    
    # Home manager input, define which version of home manager to use and which nixpkgs it should use.
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Firefox addons input, define 
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    firefox-addons
  } @ inputs:
  let
    inherit (self) outputs;

    system = "x86_64-linux";
    
    pkgs = import nixpkgs {
      config = {
        allowUnfree = true;
      };
    };
  in
  {
    # My NixOS configurations.
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };

    # My standalone home-manager configurations.
    # To run: home-manager switch --flake .#your-username@your-hostname
    homeConfigurations = {
      "nigel@desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs outputs; };
        # Home manager configuration file.
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}
