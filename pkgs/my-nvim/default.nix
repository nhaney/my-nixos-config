# Idea:
# This module will take a custom configuration that
# will be passed to the lua code as a table after it
# has been processed by the various nix functions needed
# to successfully create the neovim derivation/package.
{
  callPackage,
  neovim-unwrapped,
  wrapNeovimUnstable,
  neovimUtils,
  vimPlugins,
  vimUtils,
  lib,
  # myNvimConfig, used in both lua for configuration and in nix for what to install.
  myNvimConfig ? { },
  # Overrides for `makeNeovimConfig` to do things like unset vi alias, etc.
  makeNeovimConfigOverrides ? { },
  # Base packages required.
  ripgrep,
  fd,
  fzf,
  markdown-oxide,
  ...
}:
let

  # The base config with no optional features added.
  baseConfig = {
    greeting = "base greeting from package.";
    features = {
      neovimDev.enable = true;
      nix = {
        enable = true;
      };
      dotnet = {
        enable = false;
      };
      python = {
        enable = true;
      };
      llm = {
        enable = true;
      };
      cpp = {
        enable = true;
      };
    };
  };

  # The full config with all optional features added.
  # TODO: Maybe just have this be a comment as an example?
  fullConfig = { };

  # The config to be used by the rest of this derivation.
  finalMyNvimConfig = baseConfig // myNvimConfig;

  # Neovim plugin that is built from the lua files in this directory.
  myNvimVimPlugin = vimUtils.buildVimPlugin {
    name = "my-nvim-config";
    src = ./.;
    doCheck = false;
  };

  myPlugins = vimPlugins // (callPackage ./plugins.nix { });

  # Given a configuration, return the required external nix packages (LSP, utilities, debug servers, etc.)
  pkgsForConfig =
    config:
    let
      basePackages = [
        # Used for search
        ripgrep
        fzf
        fd

        # Markdown language server. Always used.
        markdown-oxide
      ];
    in
    basePackages
    ++ (callPackage ./features/neovim-dev.nix { features = config.features; }).packages
    ++ (callPackage ./features/nix-dev.nix { features = config.features; }).packages
    ++ (callPackage ./features/dotnet-dev.nix { features = config.features; }).packages
    ++ (callPackage ./features/python-dev.nix { features = config.features; }).packages
    ++ (callPackage ./features/cpp-dev.nix { features = config.features; }).packages
    ++ (callPackage ./features/llm.nix { features = config.features; }).packages;

  # Given a configuration, return the nix packages neovim plugins that are required.
  pluginsForConfig =
    config:
    let
      basePlugins = with myPlugins; [
        # Common dependencies
        plenary-nvim
        nvim-web-devicons

        # Convenience
        vim-sleuth
        which-key-nvim

        # Search
        telescope-nvim
        telescope-fzf-native-nvim
        telescope-ui-select-nvim

        # Syntax highlighting
        # TODO: Not sure I need all of this?
        # This isn't actually working...
        nvim-treesitter.withAllGrammars

        # LSP
        nvim-lspconfig

        # DAP
        nvim-dap
        nvim-dap-ui
        nvim-dap-virtual-text
        nvim-nio

        # Formatting
        conform-nvim

        # Completion plugins
        blink-cmp

        # File browsing
        oil-nvim

        # Markdown
        render-markdown-nvim
        zen-mode-nvim

        # Buffer and status lines
        bufferline-nvim
        lualine-nvim

        # Themes
        base16-nvim
      ];
    in
    basePlugins
    ++ (callPackage ./features/neovim-dev.nix { features = config.features; }).plugins
    ++ (callPackage ./features/nix-dev.nix { features = config.features; }).plugins
    ++ (callPackage ./features/dotnet-dev.nix { features = config.features; }).plugins
    ++ (callPackage ./features/python-dev.nix { features = config.features; }).plugins
    ++ (callPackage ./features/cpp-dev.nix { features = config.features; }).plugins
    ++ (callPackage ./features/llm.nix { features = config.features; }).plugins;

  extraPackages = pkgsForConfig finalMyNvimConfig;
in
rec {
  # The package for my custom neovim distribution.
  package = wrapNeovimUnstable neovim-unwrapped (
    neovimConfig // { plugins = neovimConfig.plugins ++ [ myNvimVimPlugin ]; }
  );

  neovimConfig =
    let
      configWithoutExtraPackages =
        neovimUtils.makeNeovimConfig {
          withPython3 = false;

          vimAlias = true;
          viAlias = true;

          customRC = ''
            lua << EOF
                require 'my-nvim-config'.setup ${lib.generators.toLua { multiline = false; } finalMyNvimConfig}
            EOF
          '';

          plugins = pluginsForConfig finalMyNvimConfig;
        }
        // makeNeovimConfigOverrides;
    in
    configWithoutExtraPackages
    // {
      wrapperArgs = configWithoutExtraPackages.wrapperArgs ++ [
        # Extra runtime deps are passed in as wrapperArgs so they are available from inside neovim.
        "--prefix"
        "PATH"
        ":"
        (lib.makeBinPath extraPackages)
      ];
    };
}
