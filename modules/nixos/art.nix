# ============================================================================
# MODULE: art
# CATEGORY: creative
# VERSION: 1.0.0
# TAGS: art drawing painting creative
# DEPS: none
# INFO: Digital art and creative tools
# ============================================================================
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    krita
    inkscape
    gimp
    obs-studio
  ];
}
