# my-nixos-config

This repo contains my:
  * NixOS machine configurations (nixosConfigurations)
  * Standalone home manager configurations (homeConfigurations)
  * Nix helper functions (lib)

## NixOS configuration installation

From the root of the repo:

```bash
$ sudo nixos-rebuild switch --flake .#desktop
```

## Home manager installation (standalone)

```bash
$ home-manager switch --flake .#your-username@your-hostname
```

## Lib functions exposed

### `lib.mkMyNeovim`

Used to create a custom neovim derivation so I can have a consistent experience between projects.

To for usage details, see [the implementation of the function here](./pkgs/my-nvim/default.nix).

