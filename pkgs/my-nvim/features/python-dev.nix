{
  lib,
  features,
  basedpyright,
  ruff,
}:
{
  packages = lib.optionals features.python.enable [
    basedpyright
    ruff
  ];
  plugins = lib.optionals features.python.enable [ ];
}
