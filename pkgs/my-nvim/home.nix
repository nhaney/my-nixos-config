# The home manager module version of the my-nvim nix package.
{
  pkgs,
  lib,
  config,
  ...
}:
let
  # The base config with no optional features added.
  baseConfig = {
    greeting = "base greeting from package.";
    features = {
      neovimDev.enable = true;
      nix.enable = true;
    };
  };

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
        type = lib.types.str;
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
  config =
    let
      neovimConfig = (pkgs.callPackage ./default.nix baseConfig).neovimConfig;

      # We want to make sure that the neovim is wrapped with NVIM_APPNAME specified by the options
      # and that it has all of the other options set as specified.
      myNvimHmConfig = neovimConfig // {
        wrapperArgs = neovimConfig.wrapperArgs ++ [
          "--set"
          "NVIM_APPNAME"
          cfg.appName
        ];
      };

      # Make sure that `wrapRc` is false so that we can use the init.lua file in this repo.
      myNvimHmPackage = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (
        myNvimHmConfig // { wrapRc = false; }
      );

      # For now, wrap this as we build it up...
      # myNvimHmWrapper = pkgs.writeShellScriptBin "my-nvim-dev" ''
      #   ${myNvimHmPackage}/bin/nvim "$@"
      # '';

    in
    lib.mkIf cfg.enable {
      # TODO: change this to myNvimHmPackage when satisfied.
      home.packages = [ myNvimHmPackage ];

      # Symlink where neovim will expect the package to where 
      home.file."${config.xdg.configHome}/${cfg.appName}".source = config.lib.file.mkOutOfStoreSymlink cfg.pathToMyNvimSource;

      home.sessionVariables = lib.mkIf cfg.defaultEditor { EDITOR = "nvim"; };
    };
}
