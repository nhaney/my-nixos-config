{
  lib,
  features,
  clang-tools,
  lldb,
  vscode-extensions,
  writeShellScriptBin,
# vimPlugins,
}:
let
  # Wrap codelldb so that neovim can just call it as an executable as per most examples.
  codelldbCommand = writeShellScriptBin "codelldb" ''
    ${vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb "$@"
  '';
in
{
  packages = lib.optionals features.cpp.enable [
    # Includes clangd, clang-format, etc.
    clang-tools

    # Includes lldb-dap
    lldb

    # Trying out code-lldb
    codelldbCommand
  ];

  plugins = lib.optionals features.cpp.enable [
  ];
}
