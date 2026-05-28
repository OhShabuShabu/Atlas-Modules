# ============================================================================
# MODULE: bluetooth
# CATEGORY: system
# VERSION: 1.0.0
# TAGS: bluetooth bluez blueman
# DEPS: none
# INFO: Bluetooth with experimental features and GUI manager
# ============================================================================
{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
  ];
}
