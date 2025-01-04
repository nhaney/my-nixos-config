{
  lib,
  features,
  basedpyright,
  ruff,
  python312Packages,
  vimPlugins,
}:
{
  packages = lib.optionals features.python.enable [
    basedpyright
    ruff
    python312Packages.debugpy
  ];
  plugins = lib.optionals features.python.enable [ vimPlugins.nvim-dap-python ];
}
