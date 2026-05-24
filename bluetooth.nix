{ pkgs, ... }:

{
  # ============================================================================
  # BLUETOOTH CONFIGURATION
  # ============================================================================
  # Enables bluetooth with experimental features and a GUI manager
  # ============================================================================

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
