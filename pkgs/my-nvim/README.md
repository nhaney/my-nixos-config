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

