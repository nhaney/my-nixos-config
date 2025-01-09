{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;

    package = pkgs.chromium;

    extensions = [
      # ublock origin
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
      # vimium
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }
      # dark reader
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }
    ];
  };
}
