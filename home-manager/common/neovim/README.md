# Neovim configuration with nix

## Goals

I want to be able to specify the following flavors of neovim:

* Base neovim
    * Lightweight, able to boot up quick but still has my preferences
    * Includes common tools that can be used in all contexts
* Language specific neovim
    * Includes everything specific to working in a language. Examples:
        * LSP packages installed
        * LSP configuration
        * Formatting
        * linting
        * debugging
        * etc.

These "flavors" should be made able to be configured separately and applied using
nix config. At the end, there should be a single derivation that contains the custom
neovim config required for a project.

Checkout this config for inspiration: https://github.com/ALT-F4-LLC/thealtf4stream.nvim
