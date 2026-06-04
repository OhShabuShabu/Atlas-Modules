{ lib, ... }: {
  flake.modules.nixos.flatpak = { pkgs, lib, config, ... }: {
    options.yorha.modules.flatpak = {
      enable = lib.mkEnableOption "Flatpak support with Flathub";
    };

    config = lib.mkIf config.yorha.modules.flatpak.enable {
      services.flatpak.enable = true;

      systemd.services.flatpak-repo = {
        wantedBy = [ "multi-user.target" ];
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        path = [ pkgs.flatpak ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo
        '';
      };
    };
  };
}
