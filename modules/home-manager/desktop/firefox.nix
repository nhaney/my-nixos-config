# Configures Firefox + extensions.
{ firefox-addons, pkgs, ... }:
{
  programs.firefox = {
    enable = true;

    profiles.nigel = {
      search.engines = {
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
        "GitHub" = {
          urls = [
            {
              template = "https://github.com/search";
              params = [
                {
                  name = "type";
                  value = "code";
                }
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          definedAliases = [ "@ghc" ];
        };
      };

      extensions = with firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        vimium
        darkreader
      ];
    };
  };
}
