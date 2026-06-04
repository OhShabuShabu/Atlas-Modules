{ lib, ... }: {
  flake.modules.nixos.gaming = { pkgs, lib, config, ... }: {
    options.yorha.modules.gaming = {
      enable = lib.mkEnableOption "gaming environment";
    };

    config = lib.mkIf config.yorha.modules.gaming.enable {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [ libva ];
        extraPackages32 = with pkgs; [ driversi686linux.libva ];
      };

      programs.steam = {
        enable = true;
        remotePlayOpenFirewall = true;
        dedicatedServer.openFirewall = true;
        gamescopeSession.enable = true;
        extraPackages = with pkgs; [
          mangohud
          gamescope
        ];
      };
    };
  };
}
