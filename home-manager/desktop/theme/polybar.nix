{ pkgs, config, ... }:
{
    services.polybar = {
        settings = {
            "bar/i3-bar" = {
                font = [
                    "${config.stylix.fonts.monospace.name};size=${builtins.toString config.stylix.fonts.sizes.desktop};antialias=true;2"
                    "${config.stylix.fonts.emoji.name};size=${builtins.toString config.stylix.fonts.sizes.desktop};antialias=true;2"
                ];
                background = "#00000000";
                height = "3.5%";
                modules-left = "i3";
                modules-center = "date time";
                modules-right = "filesystem pipewire";
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
