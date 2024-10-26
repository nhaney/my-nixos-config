{lib, vimPlugins, lua-language-server, features}:
{
    packages = lib.optionals features.neovimDev.enable [lua-language-server];
    plugins = lib.optionals features.neovimDev.enable [vimPlugins.lazydev-nvim];
}
