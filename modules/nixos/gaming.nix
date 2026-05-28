# ============================================================================
# MODULE: gaming
# CATEGORY: gaming
# VERSION: 2.0.0
# TAGS: steam gaming overlay mangohud
# DEPS: tools
# INFO: Steam with MangoHUD, 32-bit support, Millennium Steam skin
# ============================================================================
{ pkgs, lib, ... }:

{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
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

  environment.systemPackages = with pkgs; [
    mangohud
    gamescope
  ];
}
