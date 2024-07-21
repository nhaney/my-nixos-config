{ neovim, vimUtils, ...}:
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
    mkMyNeovim = { greeting }:
        neovim.override {
            configure = {
                customRC = ''
                lua << EOF
                    require 'my-nvim-config'.init("${greeting}")
                EOF
                '';
                packages.myPlugins = {
                    start = [ my-nvim-config ];
                };
            };
        };
in
mkMyNeovim { greeting = "greetings from nix"; }
