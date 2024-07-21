# Package for the neovim plugin that contains all of my configuration.
{ neovim, vimUtils, ...}:
let 
    my-nvim-config = vimUtils.buildVimPlugin {
        name = "my-nvim-config";
        src = ./.;
    };
in
neovim.override {
    configure = {
        packages.myPlugins = {
            start = [ my-nvim-config ];
        };
    };
}
