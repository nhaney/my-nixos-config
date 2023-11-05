{
  description = "NixOS and home-manager configurations for my machines.";

  inputs = {
    # Nixpkgs url that I use.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    
    # Used for installing home manager.
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Used for firefox plugins.
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
      # Is this needed?
      inherit system;
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
    # To run: home-manager --flake .#your-username@your-hostname
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
