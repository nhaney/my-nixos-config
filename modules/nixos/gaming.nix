{
  # TODO: Move steam stuff to home manager?
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  # Possibly needed for RPCS3???
  security.pam.loginLimits = [
    {
      domain = "*";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
  ];
}
