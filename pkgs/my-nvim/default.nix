{ neovim, vimUtils, lib, myNeovimConfig ? null, ...}:
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
    # Lua table can be made from nix attrset like this: https://github.com/NixOS/nixpkgs/blob/master/lib/generators.nix.
    # baseConfig is an example of the config that can be passed in.
    baseConfig = {
        greeting = "base greeting from package.";
        languageSupport = {};
    };

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
mkMyNeovim (if myNeovimConfig == null then baseConfig else myNeovimConfig)
