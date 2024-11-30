{
  config,
  pkgs,
  inputs,
  ...
}:
{
  services.silverbullet = {
    enable = true;
    listenAddress = "0.0.0.0";
    # TODO: Do this dynamically? Or with an option. Maybe this would be better set up as a home directory?
    user = "nigel";
  };

  # Allow all users in the silver bullet group to modify the files, so they
  # can be edited in other editors besides the web gui.
  # systemd.services.silverbullet.serviceConfig.StateDirectoryMode = 660;

  # So I can edit the silverbullet files.
  users.users.nigel.extraGroups = [ config.services.silverbullet.group ];
}
