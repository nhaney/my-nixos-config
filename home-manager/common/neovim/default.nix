{ nixvim, ... }:
{
  # Deprecating use of nixvim... Keeping this here for now to make sure
  # I transfer all my settings to new style of neovim config.
  # TODO: Delete this.
  # Import the base nixvim home manager module.
  # imports = [
  #   nixvim.homeManagerModules.nixvim
  #   ./theme.nix
  #   ./lualine.nix
  #   ./keymap.nix
  #   ./options.nix
  #   ./lsp.nix
  #   ./languages
  #   ./cmp.nix
  #   ./telescope.nix
  #   ./formatting.nix
  #   ./syntax.nix
  #   ./debug.nix
  # ];

  # programs.nixvim = {
  #   enable = true;
  #   defaultEditor = true;
  #   viAlias = true;
  #   vimAlias = true;
  # };
}
