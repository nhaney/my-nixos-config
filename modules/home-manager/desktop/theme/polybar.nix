{ pkgs, config, ... }:
{
    services.polybar = {
        settings = {
            "bar/i3-bar" = {
                font = [
                    "${config.stylix.fonts.monospace.name}:style=Bold;size=${builtins.toString (config.stylix.fonts.sizes.desktop + 2)};antialias=true;2"
		    # Without scaling, these appear huge.
                    # "${config.stylix.fonts.emoji.name}:style=Regular;:scale=10;size=${builtins.toString config.stylix.fonts.sizes.desktop};antialias=true;2"
                ];
                background = "#00000000";
                height = "3.5%";
                modules-left = "i3";
                modules-center = "date time";
                modules-right = "pipewire filesystem";
                tray-position = "right";
                module-margin = 2;
                border-top-size = 12;
                border-left-size = 15;
                border-right-size = 15;
                padding = 3;
                radius = 8;
            };
        };
    };
}
