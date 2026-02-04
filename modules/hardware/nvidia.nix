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
    hardware.graphics.enable32Bit = true;
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      open = true;
      nvidiaSettings = true;
      # Use the stable package for the current kernel
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    environment.variables = {
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
    };
  };
}
