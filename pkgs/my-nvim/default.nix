{ neovim, vimPlugins, vimUtils, lib, lua-language-server, myNeovimConfig ? null, ...}:
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
        neovimDevSupport = true;
    };

    extraPackagesForConfig = config:
        let
            basePackages = [];
            neovimDevPackages = [
                lua-language-server
            ];
        in
            basePackages ++ lib.optionals config.neovimDevSupport neovimDevPackages;
    pluginsForConfig = config:
        let
            basePlugins = with vimPlugins; [
                # TODO: Not sure I need all of this?
                nvim-treesitter.withAllGrammars
                nvim-lspconfig

                # The custom package.
                my-nvim-config
            ];

            neovimDevPlugins = with vimPlugins; [
                lazydev-nvim
            ];
        in
            basePlugins ++
                lib.optionals config.neovimDevSupport neovimDevPlugins;


    mkMyNeovim = config:
        neovim.override {
            configure = {
                customRC = ''
                lua << EOF
                    require 'my-nvim-config'.init ${lib.generators.toLua { multiline = false; } config}
                EOF
                '';
                packages.myPlugins.start = pluginsForConfig config;
            };
            extraMakeWrapperArgs = ''--suffix PATH : "${lib.makeBinPath (extraPackagesForConfig config)}"'';
        };
in
mkMyNeovim (if myNeovimConfig == null then baseConfig else myNeovimConfig)
