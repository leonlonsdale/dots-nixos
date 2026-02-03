{ config, lib, ... }:

let
  cfg = config.modules.hardware.nvidia;
in
{
  options.modules.hardware.nvidia = {
    enable = lib.mkEnableOption "Nvidia graphics driver configuration";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = true;
      nvidiaSettings = true;
      # Use the stable package for the current kernel
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
