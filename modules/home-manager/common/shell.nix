{
  programs.fish = {
    enable = true;
    shellInit = ''
      set -gx EDITOR nvim
    '';
  };
}
