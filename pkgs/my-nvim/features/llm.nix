{
  lib,
  features,
  nodejs-18_x,
  vimPlugins,
}:
{
  packages = lib.optionals features.llm.enable [
    nodejs-18_x
  ];

  plugins = lib.optionals features.llm.enable [
    vimPlugins.avante-nvim
    vimPlugins.copilot-vim
  ];
}
