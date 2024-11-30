# Configures Firefox + extensions.
{ firefox-addons, ...}:
{
  programs.firefox = {
    enable = true;

    profiles.nigel = {
      extensions = with firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        vimium
      ];
    };
  };
}
