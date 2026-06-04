{ lib, ... }: {
  flake.modules.nixos.virtualisation = { pkgs, lib, config, ... }: {
    options.yorha.modules.virtualisation = {
      enable = lib.mkEnableOption "virtualisation tools";

      username = lib.mkOption {
        type = lib.types.str;
        default = "yusa";
        description = "Primary username for libvirt group membership";
      };
    };

    config = lib.mkIf config.yorha.modules.virtualisation.enable {
      programs.virt-manager.enable = true;

      users.users.${config.yorha.modules.virtualisation.username}.extraGroups = [ "libvirtd" ];

      virtualisation.libvirtd = {
        enable = true;
        firewallBackend = "nftables";
        qemu.verbatimConfig = ''
          namespaces = []
          cgroup_device_acl = [
            "/dev/null", "/dev/full", "/dev/zero",
            "/dev/random", "/dev/urandom",
            "/dev/ptmx", "/dev/kvm",
            "/dev/kvmfr0",
            "/dev/rtc", "/dev/hpet"
          ]
        '';
      };

      systemd.services.libvirtd.postStart = ''
        ${pkgs.libvirt}/bin/virsh net-info default 2>/dev/null || {
          ${pkgs.libvirt}/bin/virsh net-define ${pkgs.libvirt}/var/lib/libvirt/qemu/networks/default.xml
        }
        ${pkgs.libvirt}/bin/virsh net-autostart default 2>/dev/null || true
        ${pkgs.libvirt}/bin/virsh net-start default 2>/dev/null || true
      '';

      environment.etc."nftables/vm-forward.conf" = {
        mode = "0444";
        text = ''
          table inet allow-vm-forward {
            chain forward {
              type filter hook forward priority -1; policy accept;
              iif "virbr0" accept
            }
          }
        '';
      };

      systemd.services.nft-vm-forward = {
        description = "Allow VM forwarded traffic through nftables";
        after = [ "libvirtd.service" ];
        bindsTo = [ "libvirtd.service" ];
        partOf = [ "libvirtd.service" ];
        wantedBy = [ "libvirtd.service" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = "${pkgs.nftables}/bin/nft -f /etc/nftables/vm-forward.conf";
          ExecStop = "${pkgs.nftables}/bin/nft delete table inet allow-vm-forward 2>/dev/null || true";
          ExecReload = "${pkgs.nftables}/bin/nft -f /etc/nftables/vm-forward.conf";
        };
      };

      systemd.services.libvirtd.serviceConfig.LoadCredentialEncrypted = lib.mkDefault [ "" ];

      boot.kernelModules = [
        "sch_htb" "sch_sfq" "sch_fq" "sch_fq_codel" "sch_prio"
        "cls_u32" "act_police" "act_csum" "kvmfr"
      ];

      boot.extraModulePackages = with config.boot.kernelPackages; [ kvmfr ];

      virtualisation.docker.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;

      environment.systemPackages = with pkgs; [
        distrobox docker docker-compose looking-glass-client
      ];

      boot.extraModprobeConfig = ''
        options kvmfr static_size_mb=64
      '';

      services.udev.extraRules = ''
        KERNEL=="kvmfr*", OWNER="${config.yorha.modules.virtualisation.username}", GROUP="kvm", MODE="0660"
      '';

      security.apparmor.includes."local/abstractions/libvirt-qemu" = ''
        /dev/kvmfr0 rw,
      '';

      boot.kernel.sysctl."vm.nr_hugepages" = 1024;

      environment.etc."xdg/looking-glass/client.ini" = {
        text = ''
          [app]
          shmFile=/dev/kvmfr0
        '';
      };
    };
  };
}
