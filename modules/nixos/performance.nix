{ lib, ... }: {
  flake.modules.nixos.performance = { lib, config, ... }: {
    options.yorha.modules.performance = {
      enable = lib.mkEnableOption "performance tuning";
      zramPercent = lib.mkOption {
        type = lib.types.int;
        default = 50;
        description = "ZRAM size as percentage of total RAM";
      };
      cpuGovernor = lib.mkOption {
        type = lib.types.str;
        default = "performance";
        description = "CPU frequency governor";
      };
    };

    config = lib.mkIf config.yorha.modules.performance.enable {
      boot.kernelModules = [ "tcp_bbr" ];

      powerManagement.cpuFreqGovernor = config.yorha.modules.performance.cpuGovernor;

      nix.settings = {
        max-jobs = lib.mkDefault "auto";
        cores = lib.mkDefault 0;
        auto-optimise-store = true;
        min-free = 500000000;
      };

      nix.gc = {
        automatic = true;
        dates = "weekly";
      };

      zramSwap.enable = true;
      zramSwap.memoryPercent = config.yorha.modules.performance.zramPercent;
    };
  };
}
