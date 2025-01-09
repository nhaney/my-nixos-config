{
  lib,
  features,
  basedpyright,
  ruff,
  vimPlugins,
  python312,
  writeShellScriptBin,
}:
let
  # Needed because debugpy pip package does not install the adapter executable, just the server.
  my-debugpy-interpreter = python312.withPackages (ps: [ ps.debugpy ]);
  my-debugpy = writeShellScriptBin "my-debugpy" ''
    ${my-debugpy-interpreter}/bin/python -m debugpy.adapter
  '';
in
{
  packages = lib.optionals features.python.enable [
    basedpyright
    ruff
    my-debugpy
  ];
  plugins = lib.optionals features.python.enable [ vimPlugins.nvim-dap-python ];
}
