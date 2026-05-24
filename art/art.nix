{ pkgs, ... }:

{
  # ============================================================================
  # ART & CREATIVE CONFIGURATION
  # ============================================================================
  # Installs creative applications and enables drawing tablet support
  # ============================================================================

  # OpenTabletDriver — driver for most drawing tablets (Wacom, Huion, XP-Pen, etc.)
  hardware.opentabletdriver.enable = true;

  environment.systemPackages = with pkgs; [
    # Raster graphics
    gimp-with-plugins
    krita
    mypaint

    # Vector graphics
    inkscape

    # 3D modelling
    blender
  ];
}
