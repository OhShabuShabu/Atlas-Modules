{ lib, ... }: {
  flake.modules.nixos.gpu-intel = { lib, config, ... }: {
    options.yorha.modules.gpu-intel = {
      enable = lib.mkEnableOption "Intel GPU initrd kernel module";
    };

    config = lib.mkIf config.yorha.modules.gpu-intel.enable {
      boot.initrd.kernelModules = [ "i915" ];
      boot.initrd.availableKernelModules = [ "i915" ];
    };
  };
}
