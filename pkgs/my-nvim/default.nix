{ neovim, neovim-unwrapped, makeNeovimConfig, wrapNeovimUnstable, vimUtils, lib, ...}:
let 
    # Neovim plugin.
    my-nvim-config = vimUtils.buildVimPlugin {
        name = "my-nvim-config";
        src = ./.;
    };

    # Idea:
    # mkMyNeovim will take a custom configuration that
    # will be passed to the lua code as a table after it
    # has been processed by the various nix functions needed
    # to successfully create the neovim derivation.
    # Lua table can be made from nix attrset like this: https://github.com/NixOS/nixpkgs/blob/master/lib/generators.nix
    mkMyNeovim = config:
        neovim.override {
            configure = {
                customRC = ''
                lua << EOF
                    require 'my-nvim-config'.init(${lib.generators.toLua { multiline = false; } config})
                EOF
                '';
                packages.myPlugins = {
                    start = [ my-nvim-config ];
                };
            };
        };
in
mkMyNeovim { greeting = "greetings from nix"; }
