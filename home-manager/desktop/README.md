# Desktop config

This folder contains all of the configuration for desktop environments. This is used for systems that have a desktop GUI.

## Goals

* [x] i3 workspaces
* [x] picom transparant background blurring
* [x] Generate base16 theme with flavours
* [x] Install flavours
* [x] i3 + polybar + rofi theming with stylix
* [x] polybar i3 configuration
* [x] polybar audio and volume control
* [x] polybar network control
    * Wifi
    * Ethernet
    * Airplane mode
* [x] polybar bluetooth control
* [ ] polybar disk space
* [ ] Dunst notifications

## Future things to work on

* [ ] Polybar change to using nix based settings instead of file for separate theming.
* [ ] Wrap up https://github.com/claudius-kienle/polybar-pipewire-control/blob/master/README.md as a derivation + polybar module
* [ ] Separate out theme of polybar modules from general positioning/functionality.
* [ ] Auto launch i3 workspace (maybe a special labeled one?) with settings windows.
    * Nvidia settings
    * pavucontrol
    * bluetooth
    * etc.
