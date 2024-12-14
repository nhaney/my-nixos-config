{
  lib,
  roslyn-ls,
  features,
  #  vimPlugins,
  dotnet-sdk_9,
  fetchFromGitHub,
  vimUtils,
}:
let
  # TODO: fix this so we don't need EOL dotnet 6
  # sdkOverride = dotnetCorePackages.sdk_9_0;
  # roslyn-ls-no-sdk6 = roslyn-ls.overrideAttrs { dotnet-sdk = dotnet-sdk_9; };

  # Build the roslyn-nvim fork instead of the one in nixpkgs.
  # Can remove once upstream PR is merged: https://github.com/NixOS/nixpkgs/pull/365083
  roslyn-nvim-fork = vimUtils.buildVimPlugin {
    pname = "roslyn.nvim";
    version = "2024-12-13";
    src = fetchFromGitHub {
      owner = "seblj";
      repo = "roslyn.nvim";
      rev = "6d591af98e0fac1d382de15de88d26df53ec8b67";
      sha256 = "sha256-JQDQIteuiS0gwu4KauDtlzMIlMWwLzrXsGQ02oEC/Ww=";
    };
    meta.homepage = "https://github.com/seblj/roslyn.nvim";
  };
in
{
  packages = lib.optionals features.dotnet.enable [
    roslyn-ls
    dotnet-sdk_9
  ];
  plugins = lib.optionals features.dotnet.enable [ roslyn-nvim-fork ];
}
