{ lib, nixd, nil, nixfmt-rfc-style, features }:
{
    packages = lib.optionals features.nix.enable [ nixd nil nixfmt-rfc-style ];
    plugins = lib.optionals features.nix.enable [ ];
}
