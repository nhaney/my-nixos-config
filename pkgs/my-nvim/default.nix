# Idea:
# This module will take a custom configuration that
# will be passed to the lua code as a table after it
# has been processed by the various nix functions needed
# to successfully create the neovim derivation/package.
{ neovim-unwrapped, wrapNeovimUnstable, neovimUtils, vimPlugins, vimUtils, lib, lua-language-server, myNeovimConfig ? {}, ...}:
let 

    # The base configuration of the package overridden by the config passed in.
    # TODO: Figure out how to override this properly.
    baseConfig = {
        greeting = "base greeting from package.";
        features = {};
        tools = {};
        neovimDevSupport = false;
    }; #// myNeovimConfig;

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

            plugins = pluginsForConfig finalConfig;
        } // config.extraMakeConfigArgs;
in rec
{
    # The configuration generated based on the passed in config.
    neovimConfig = let 
        configWithoutExtraPackages = mkMyNeovimConfig finalConfig;
    in
        configWithoutExtraPackages // {
            wrapperArgs = configWithoutExtraPackages.wrapperArgs ++ [
              # Extra runtime deps are passed in as wrapperArgs so they are available from inside neovim.
              "--prefix"
              "PATH"
              ":"
              (lib.makeBinPath extraPackages)
            ];
        };

    # The extra nix packages required for the config.
    extraPackages = pkgsForConfig finalConfig;

    # The final wrapped neovim package containing everything needed for the passed in configuration.
    package = wrapNeovimUnstable neovim-unwrapped neovimConfig;

    # Installs neovim in "dev mode" where lua files can be edited without rebuilding the neovim package, but plugins
    # and extra packages are still managed by nix and will 
    # TODO: Make this also be compatible without the "dev mode" and just install the package normally.
    # For now this isn't needed as I want to always be able to hot-reload my config on the host side.
    hmModule = { config, pkgs, ... }:
    let
        cfg = config.programs.my-nvim;
    in
    {
        options = {
            programs.my-nvim = {
                enable = lib.mkEnableOption "MyNeovim";

                pathToMyNvimSource = lib.mkOption {
                    type = lib.types.path;
                    description = ''
                        The path to the source of the MyNeovim plugin. This option specifies
                        the path where the lua config is sourced from instead
                        of the wrapped neovim from the MyNeovim package. This allows for the hot-reloading
                        of lua neovim config without rebuilding nix. For example, this could be in
                        "/home/<username>/my-nixos-config/pkgs/my-nvim".
                    '';
                };

                defaultEditor = lib.mkOption {
                    type = lib.types.bool;
                    default = false;
                    description = ''
                        Whether to configure {command}`nvim` as the default
                        editor using the {env}`EDITOR` environment variable.
                    '';
                };

                appName = lib.mkOption {
                    type = lib.types.string;
                    default = "my-nvim";
                    description = ''
                        The name that the neovim executable will use as its `NVIM_APPNAME` environment
                        variable when being called. Configuration will be symlinked from `$XDG_CONFIG_HOME/$NVIM_APPNAME`
                        which is where neovim looks for app specific config to wherever was specified in the `pathToMyNvimSource`
                        option.
                    '';
                }

                extraMakeConfigArgs = lib.mkOption {
                    type = lib.types.attrs;
                    description = ''
                        Extra attributes to pass to the 'vimUtils.makeNeovimConfig' function.
                        For example, you can use things like `viAlias`, `vimAlias`, etc.
                    '';
                    default = {};
                };
            };
        };
        config = let 
            # We want to make sure that the neovim is wrapped with NVIM_APPNAME specified by the options
            # and that it has all of the other options set as specified.

            myNvimConfigWithHmAttrs = finalConfig // {
                extraMakeConfigArgs = finalConfig.extraMakeConfigArgs // cfg.extraMakeConfigArgs;
            };
        in lib.mkIf cfg.enable {
            # Include extra packages to be installed by home manager so they can be accessed by normal means.
            home.packages = extraPackages;

            # Symlink where neovim will expect the package to where 
            home.file."${config.xdg.configHome}/${cfg.appName}".source = config.lib.file.mkOutOfStoreSymlink cfg.pathToMyNvimSource;
        };

# let
#     # My actual neovim package.
#     myNvim = (pkgs.callPackage ../../pkgs/my-nvim {}).package;
#     my-nvim-wrapper = pkgs.writeShellScriptBin "my-nvim" ''
#         ${myNvim}/bin/nvim "$@"
#     '';
# 
#     # My dev neovim package with hot reloading.
#     pathToMyNvimSource = "${config.home.homeDirectory}/my-nixos-config/pkgs/my-nvim";
# 
#     # By doing this, we force neovim to use the my-nvim config that is later symlinked to 
#     # the files in this repo. This allows for hot-reloading of the config without a nix rebuild.
#     my-nvim-dev-wrapper = pkgs.writeShellScriptBin "my-nvim-dev" ''
#         NVIM_APPNAME=my-nvim ${pkgs.neovim-unwrapped}/bin/nvim "$@"
#     '';
# in
# {
#   # My custom neovim package.
#   home.packages = [
#     my-nvim-wrapper
#     my-nvim-dev-wrapper
#   ];
# 
# }
    };
}
