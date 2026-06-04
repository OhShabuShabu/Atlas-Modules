{ lib, ... }: {
  flake.modules.nixos.security = { pkgs, lib, config, ... }: {
    options.yorha.modules.security = {
      enable = lib.mkEnableOption "security hardening module";
      fail2ban = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable fail2ban for SSH brute-force protection";
      };
    };

    config = lib.mkIf config.yorha.modules.security.enable {
      security = {
        sudo = {
          enable = true;
          wheelNeedsPassword = true;
        };
        lockKernelModules = false;
        protectKernelImage = true;
      };

      services.fail2ban = lib.mkIf config.yorha.modules.security.fail2ban {
        enable = true;
        maxretry = 5;
        bantime = "1h";
      };

      boot.kernel.sysctl = {
        "kernel.dmesg_restrict" = 1;
        "kernel.kptr_restrict" = 2;
        "net.core.bpf_jit_enable" = 0;
        "net.ipv4.conf.all.rp_filter" = 1;
        "net.ipv4.conf.default.rp_filter" = 1;
      };

      environment.systemPackages = with pkgs; [ lynis ];
    };
  };
}
