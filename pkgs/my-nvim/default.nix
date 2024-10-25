# Idea:
# This module will take a custom configuration that
# will be passed to the lua code as a table after it
# has been processed by the various nix functions needed
# to successfully create the neovim derivation/package.
{ neovim-unwrapped, wrapNeovimUnstable, neovimUtils, vimPlugins, vimUtils, lib, lua-language-server, myNeovimConfig ? {}, ...}:
let 

    # The base configuration of the package overridden by the config passed in.
    finalConfig = {
        greeting = "base greeting from package.";
        languageSupport = {};
        neovimDevSupport = false;
    } // myNeovimConfig;

    # Given a configuration, return the required external nix packages (LSP, utilities, debug servers, etc.)
    pkgsForConfig = config:
        let
            basePackages = [];
            neovimDevPackages = [
                lua-language-server
            ];
        in
            basePackages ++ lib.optionals config.neovimDevSupport neovimDevPackages;

    # Neovim plugin that is built from the lua files in this directory.
    my-nvim-config = vimUtils.buildVimPlugin {
        name = "my-nvim-config";
        src = ./.;
    };

    # Given a configuration, return the nix packages neovim plugins that are required.
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


    mkMyNeovimConfig = config:
        neovimUtils.makeNeovimConfig {
            withPython3 = false;
            withRuby = false;
            withNodeJs = false;

            extraLuaPackages = (lp: []);

            customRC = ''
                lua << EOF
                    require 'my-nvim-config'.init ${lib.generators.toLua { multiline = false; } config}
                EOF
            '';

            plugins = pluginsForConfig myNeovimConfig;
        };
in rec
{
    # The configuration generated based on the passed in config.
    neovimConfig = mkMyNeovimConfig finalConfig;

    # The extra nix packages required for the config.
    extraPackages = pkgsForConfig finalConfig;

    # The final wrapped neovim package containing everything needed for the passed in configuration.
    package = wrapNeovimUnstable neovim-unwrapped (finalConfig // {
        wrapperArgs = neovimConfig.wrapperArgs ++ [
          # extra runtime deps
          "--prefix"
          "PATH"
          ":"
          (lib.makeBinPath extraPackages)
        ];
    });

    # TODO: Home manager module can also be exposed here? Maybe it would be better to put in another file?
}
