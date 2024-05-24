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

These "flavors" should be made available as a separate nix functions that can apply to a base derivation:

Example:
```

```
