# My-nvim

## Goals

### Neovim configuration done in Lua

* All configuration for neovim should be done in native lua. This configuration can be used by nix as a folder of lua files.
* Single plugin as entrypoint for my entire configuration.
* Plugin modularized with different "features"
    * Base: my keymaps, vim config, and necessary plugin config.
    * Language-specific: everything specific to a certain language.
    * Optional features: things like copilot, etc.
* Flavors of configuration can be specified by passing in a `config` lua table to the `init()` function of my plugin.

### Dependency installation done with nix


### Lua-centric neovim configuration

* Neovim plugin that contains all of my configuration.
* Plugin written in lua to prevent complete translation from nix -> lua.
* All dependencies of the plugin can be either manually installed or installed via nix.
* Configuration passed into nix function to create app will identify all extra packages (e.g. language servers)
* Easy development with a custom neovim app name setup in home-manager for quicker scripting/iterations.

### Neovim in nixpkgs

In [all-packages.nix](https://github.com/NixOS/nixpkgs/blob/768ddf7007a154a502f22fb31e08302ae4154b27/pkgs/top-level/all-packages.nix) there
is currently :
    * wrapNeovimUnstable -> lower level neovim wrapper. Defined by [wrapper.nix](https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/neovim/wrapper.nix).
    * wrapNeovim -> higher level wrapper -> uses the neovim [utils.nix](https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/neovim/utils.nix) `legacyWrapper` function.
    * neovim-unwrapped -> just neovim, [defined here](https://github.com/NixOS/nixpkgs/blob/9f918d616c5321ad374ae6cb5ea89c9e04bf3e58/pkgs/by-name/ne/neovim-unwrapped/package.nix#L192)
    * neovim -> `wrapNeovim neovim-unwrapped`


The neovim wrapper takes the arguments that can be generated by `makeNeovimConfig` in the utils files as the `wrapperArgs` argument.

`makeNeovimConfig` simply just returns an attrset containing the proper arguments that are expected in the wrapNeovimUnstable to contain
things like the plugins, etc.


#### Config examples using this

https://github.com/viperML/dotfiles/blob/098fb8c32498cedb30be69562ec99137eb32d5d3/packages/neovim/default.nix

Also look at what home manager does: https://github.com/nix-community/home-manager/blob/5ec753a1fc4454df9285d8b3ec0809234defb975/modules/programs/neovim.nix

#### Ideas after research

* Create a wrapper function over wrapNeovimUnstable and makeNeovimConfig that takes a simple attrset that is the main configuration entrypoint.
    * The configuration should be able to be easily expanded in the future.
    * The proper nix packages are installed based on the configuration for external dev tools (e.g. LSPs, debug servers, etc.)
    * The proper vim plugins are installed.
    * A home manager module is exposed which allows for the dev version of the neovim config to be defined that can be hot-reloaded with the out of store symlink functionality.
    * The wrapper can be used to install a neovim derivation specific to any project with only the required dependencies. This will be referenced from my
