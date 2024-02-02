# My NixOS and Home Manager configurations

This repo contains my NixOS config for my machines and home manager configs for the machines.

## TODO

### NixOS

* [x] Fix Windows time.
* [ ] Use only i3 without a desktop environment
    * [x] Install alacritty terminal
    * [ ] Install fonts
      * [ ] Create consistent fonts across GUI
    * [ ] Install bluetooth program
    * [ ] Install audio program
    * [ ] Install display program (can I use nvidia for this?)
      * [ ] Make sure that the correct resolution is setup for my monitor when it boots up (5110x1440, 240hz)
    * [ ] Network GUI?
      * [ ] nm-connection-editor will work I think?

### Home manager

* [ ] Incorporate existing neovim configuration into nixvim
* [ ] Separate out terminal and GUI apps in config
  * See https://github.com/GaetanLepage/dotfiles/tree/11c372616dad8ee330bc1583b80978e50976c63f/home/modules for inspo
* [ ] Configure alacritty with home-manager
* [ ] Configure i3 with home-manager
* [ ] Configure tmux with home-manager
