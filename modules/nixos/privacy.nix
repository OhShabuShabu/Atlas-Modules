{ lib, ... }: {
  flake.modules.nixos.privacy = { pkgs, lib, config, ... }: {
    options.yorha.modules.privacy = {
      enable = lib.mkEnableOption "privacy suite";

      username = lib.mkOption {
        type = lib.types.str;
        default = "yusa";
        description = "Primary username for privacy module configuration";
      };

      enableAutoMetadataStrip = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };

    config = lib.mkIf config.yorha.modules.privacy.enable {
      services.mullvad-vpn.enable = true;

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 53 853 ];
        allowedUDPPorts = [ 53 853 51820 ];
      };

      programs.mullvad-browser.enable = true;

      systemd.user.services.mat2-service = lib.mkIf config.yorha.modules.privacy.enableAutoMetadataStrip {
        enable = true;
        description = "Auto-strip metadata from downloaded files";
        wantedBy = [ "default.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = false;
        };
        script = ''
          ${pkgs.mat2}/bin/mat2 --quiet "$HOME/Downloads/" 2>/dev/null || true
        '';
      };

      environment.systemPackages = with pkgs; [ libnotify mat2 ];
    };
  };
}
