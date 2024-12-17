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
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}
