{ pkgs, config, lib, stylix, ... }:
{
  imports = [
    stylix.homeManagerModules.stylix
    ./flameshot.nix
    ./picom.nix
    ./rofi.nix
    ./i3.nix
    ./polybar.nix
  ];

  home.packages = with pkgs; [
    # Used for desktop background.
    feh
  ];

  # home.file.".background.jpg".source = ./ultrawide_black_knight.jpg;

  #xsession.windowManager.i3.config.startup = [
  #  {
  #    command = "${pkgs.feh}/bin/feh --bg-fill ~/.background.jpg";
  #    always = true;
  #    notification = false;
  #  }
  #];

  stylix.image = ./anor_londo_day.jpg;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/zenburn.yaml";

  stylix.polarity = "dark";

  # For now disable on vim because it isn't applying correctly.
  stylix.targets.nixvim.enable = false;
  
  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      package = (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; } );
      name = "FiraCode Nerd Font";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
}
