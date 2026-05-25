{ pkgs, lib, ... }: {
  # Non-essential desktop extras: AI/ML, animated wallpapers
  # These packages are heavy and not required for the base desktop experience.
  environment.systemPackages = with pkgs; [
    # AI/ML
    ollama-rocm

    # Animated wallpapers
    linux-wallpaperengine
    mpvpaper
  ];
}
