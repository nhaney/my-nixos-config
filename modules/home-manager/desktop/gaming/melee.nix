{
  config,
  slippi,
  lib,
  ...
}:
{
  imports = [
    slippi.homeManagerModules.default
  ];

  slippi-launcher = {
    enable = true;
    isoPath = "${config.home.homeDirectory}/games/gamecuberoms/ssbm.iso";
    netplayHash = "sha256-XspvaRlLNAeJ2KyagS4PWOqaJHVZqvw/a3Z3mAxOFJI=";
    launchMeleeOnPlay = false;
  };
}
