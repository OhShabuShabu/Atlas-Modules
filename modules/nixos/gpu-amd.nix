{ lib, ... }: {
  flake.modules.nixos.gpu-amd = { lib, config, ... }: {
    options.yorha.modules.gpu-amd = {
      enable = lib.mkEnableOption "AMD GPU initrd kernel module";
    };

    config = lib.mkIf config.yorha.modules.gpu-amd.enable {
      boot.initrd.kernelModules = [ "amdgpu" ];
      boot.initrd.availableKernelModules = [ "amdgpu" ];
    };
  };
}
