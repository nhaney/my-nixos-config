# my-nixos-config

This repo contains my:
  * NixOS machine configurations (nixosConfigurations)
  * Standalone home manager configurations (homeConfigurations)
  * Nix helper functions (lib)

## NixOS configuration installation

From the root of the repo:

```bash
$ sudo nixos-rebuild switch --flake .#<hostname>
```

## Home manager installation (standalone)

```bash
$ home-manager switch --flake .#your-username@<hostname>
```

## Lib functions exposed

### `lib.mkMyNeovim`

Used to create a custom neovim derivation so I can have a consistent experience between projects.

#### Usage in Another Flake

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    my-nixos-config = {
      url = "github:youruser/my-nixos-config";  # or path/git URL
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, my-nixos-config, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

    # Create a custom neovim with your config
    myNeovim = my-nixos-config.lib.mkMyNeovim {
      myNvimConfig = {
        greeting = "Welcome to my project!";
        features = {
          nix.enable = true;
          dotnet.enable = true;
          python.enable = true;
          cpp.enable = false;
          llm.enable = true;
          neovimDev.enable = false;
        };
      };
    };
  in {
    # Use it in a devShell
    devShells.${system}.default = pkgs.mkShell {
      packages = [ myNeovim ];
    };

    # Or as a standalone package
    packages.${system}.nvim = myNeovim;
  };
}
```

#### Available Features

| Feature | Default | Purpose |
|---------|---------|---------|
| `neovimDev.enable` | `false` | Neovim plugin development |
| `nix.enable` | `true` | Nix language support |
| `dotnet.enable` | `false` | .NET language support |
| `python.enable` | `false` | Python language support |
| `cpp.enable` | `false` | C++ language support |
| `llm.enable` | `false` | LLM plugins |

Your config is merged with the base config via `lib.recursiveUpdate`, so you only need to specify the features you want to change from defaults.

For implementation details, see [the source](./pkgs/my-nvim/default.nix).
