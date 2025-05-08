# Config to work with my RTX 3070.
{ config, ... }:
{
  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    # I have a 3070, so this is set to true. If older, set to false.
    # TODO: Maybe make this a module options?
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}
