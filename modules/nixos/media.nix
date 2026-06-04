{ lib, ... }: {
  flake.modules.nixos.media = { pkgs, lib, config, ... }: {
    options.yorha.modules.media = {
      enable = lib.mkEnableOption "media codecs and playback tools";
      hardwareAcceleration = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable hardware video acceleration";
      };
    };

    config = lib.mkIf config.yorha.modules.media.enable {
      hardware.graphics = lib.mkIf config.yorha.modules.media.hardwareAcceleration {
        enable = true;
        extraPackages = with pkgs; [ intel-media-driver vaapiIntel libvdpau-va-gl vaapiVdpau ];
      };

      environment.systemPackages = with pkgs; [
        ffmpeg
        ffmpegthumbnailer
        vlc
        mpv
        imv
        libva-utils
        vdpauinfo
      ];

      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "intel-media-driver"
      ];
    };
  };
}
