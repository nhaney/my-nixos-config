# Idea:
# This module will take a custom configuration that
# will be passed to the lua code as a table after it
# has been processed by the various nix functions needed
# to successfully create the neovim derivation/package.
{ callPackage, neovim-unwrapped, wrapNeovimUnstable, neovimUtils, vimPlugins, vimUtils, lib,
    # myNvimConfig, used in both lua for configuration and in nix for what to install.
    myNvimConfig ? {},
    # overrides for `makeNeovimConfig` to do things like unset vi alias, etc.
    makeNeovimConfigOverrides ? {},
...}:
let 

    # The base config with no optional features added.
    baseConfig = {
        greeting = "base greeting from package.";
        features = { neovimDev.enable = false; };
    };


    # The full config with all optional features added.
    # TODO: Maybe just have this be a comment as an example?
    fullConfig = {};

    # The config to be used by the rest of this derivation.
    finalMyNvimConfig = baseConfig // myNvimConfig;

    # Neovim plugin that is built from the lua files in this directory.
    myNvimVimPlugin = vimUtils.buildVimPlugin {
        name = "my-nvim-config";
        src = ./.;
    };

    # Given a configuration, return the required external nix packages (LSP, utilities, debug servers, etc.)
    pkgsForConfig = config:
        let
            basePackages = [];
        in
            basePackages 
                ++ (callPackage ./features/neovim-dev.nix { features = config.features; }).packages;

    # Given a configuration, return the nix packages neovim plugins that are required.
    pluginsForConfig = config:
        let
            basePlugins = with vimPlugins; [
                # TODO: Not sure I need all of this?
                nvim-treesitter.withAllGrammars
                nvim-lspconfig
            ];
        in
            basePlugins
                ++ (callPackage ./features/neovim-dev.nix { features = config.features; }).plugins;

    extraPackages = pkgsForConfig finalMyNvimConfig;

    neovimConfig = let 
        configWithoutExtraPackages = neovimUtils.makeNeovimConfig {
            withPython3 = false;

            vimAlias = true;
            viAlias = true;

            customRC = ''
                lua << EOF
                    require 'my-nvim-config'.init ${lib.generators.toLua { multiline = false; } finalMyNvimConfig}
                EOF
            '';

            plugins = pluginsForConfig finalMyNvimConfig;
        } // makeNeovimConfigOverrides;
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
in
{
    # The package for my custom neovim distribution.
    package = wrapNeovimUnstable neovim-unwrapped (neovimConfig // { plugins = neovimConfig.plugins ++ [ myNvimVimPlugin ] ;});

    # Home manager module that installs neovim in "dev mode" where lua files can be edited without rebuilding the neovim package, but plugins
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
                };
            };
        };
        config = let 
            # We want to make sure that the neovim is wrapped with NVIM_APPNAME specified by the options
            # and that it has all of the other options set as specified.
            myNvimHmConfig = neovimConfig //
                {
                    wrapperArgs = neovimConfig.wrapperArgs ++ [
                        "NVIM_APPNAME"
                        cfg.appName
                    ];
            };

            # Make sure that `wrapRc` is false so that we can use the init.lua file in this repo.
            myNvimHmPackage = wrapNeovimUnstable neovim-unwrapped myNvimHmConfig // { wrapRc = false; };

            # For now, wrap this as we build it up...
            myNvimHmWrapper = pkgs.writeShellScriptBin "my-nvim-dev" ''
                ${myNvimHmPackage}/bin/nvim "$@"
            '';

        in lib.mkIf cfg.enable {
            home.packages = [ myNvimHmWrapper ];

            # Symlink where neovim will expect the package to where 
            home.file."${config.xdg.configHome}/${cfg.appName}".source = config.lib.file.mkOutOfStoreSymlink cfg.pathToMyNvimSource;

            # TODO: renable this once I use this as my primary editor.
            # home.sessionVariables = lib.mkIf cfg.defaultEditor { EDITOR = "nvim"; };
        };
    };
}
