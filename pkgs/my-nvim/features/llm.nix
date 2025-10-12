{
  lib,
  features,
  nodejs,
  vimPlugins,
}:
{
  packages = lib.optionals features.llm.enable [
    nodejs
  ];

  plugins = lib.optionals features.llm.enable [
    vimPlugins.avante-nvim
    # vimPlugins.copilot-vim
  ];
}
