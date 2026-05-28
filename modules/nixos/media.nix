# ============================================================================
# MODULE: media
# CATEGORY: system
# VERSION: 1.0.0
# TAGS: media codecs video audio playback
# DEPS: none
# INFO: Media codecs, playback tools, and multimedia libraries
# ============================================================================
{ config, pkgs, lib, ... }:

let
  cfg = config.atlas.modules.media;
in {
  options.atlas.modules.media = {
    enable = lib.mkEnableOption "media codecs and playback tools";
    hardwareAcceleration = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable hardware video acceleration";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.opengl = lib.mkIf cfg.hardwareAcceleration {
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
}
