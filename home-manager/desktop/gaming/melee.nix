{ config, ... }:
{
    slippi-launcher = {
        enable = true;
        isoPath = "${config.home.homeDirectory}/games/gamecuberoms/ssbm.iso";
        netplayHash = "sha256-QsvayemrIztHSVcFh0I1/SOCoO6EsSTItrRQgqTWvG4=";
        launchMeleeOnPlay = false;
    };
}
