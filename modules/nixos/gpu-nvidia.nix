{ lib, ... }: {
  flake.modules.nixos.gpu-nvidia = { lib, config, ... }: {
    options.yorha.modules.gpu-nvidia = {
      enable = lib.mkEnableOption "NVIDIA GPU initrd kernel module";
      useProprietary = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Use proprietary NVIDIA driver instead of nouveau for initrd";
      };
    };

    config = lib.mkIf config.yorha.modules.gpu-nvidia.enable {
      boot.initrd.kernelModules = if config.yorha.modules.gpu-nvidia.useProprietary
        then [ "nvidia" "nvidia_modeset" "nvidia_drm" ]
        else [ "nouveau" ];
      boot.initrd.availableKernelModules = if config.yorha.modules.gpu-nvidia.useProprietary
        then [ "nvidia" "nvidia_modeset" "nvidia_drm" ]
        else [ "nouveau" ];
    };
  };
}
