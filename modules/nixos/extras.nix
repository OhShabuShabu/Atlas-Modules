# ============================================================================
# MODULE: extras
# CATEGORY: extras
# VERSION: 1.0.0
# TAGS: ai ml ollama wallpaper
# DEPS: none
# INFO: AI/ML (Ollama ROCm), animated wallpapers via mpvpaper
# ============================================================================
{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    ollama-rocm
    linux-wallpaperengine
    mpvpaper
  ];
}
