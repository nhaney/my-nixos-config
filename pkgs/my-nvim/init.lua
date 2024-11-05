require 'my-nvim-config'.setup({
    features = {
        neovimDev = {
            enable = true
        },
        nix = {
            enable = true,
            -- This needs to change based on where this flake was cloned.
            nixPkgsFlakePath = "/home/nigel/my-nixos-config",
        }
    },
    ["test"] = "value"
})
