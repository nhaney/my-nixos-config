{
  lib,
  roslyn-ls,
  features,
  vimPlugins,
  dotnet-sdk_9,
}:
{
  packages = lib.optionals features.dotnet.enable [
    roslyn-ls
    dotnet-sdk_9
  ];
  plugins = lib.optionals features.dotnet.enable (with vimPlugins; [ roslyn-nvim ]);
}
