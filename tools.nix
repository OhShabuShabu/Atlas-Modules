{ pkgs, ... }:

{
  # Core utilities
  home.packages = with pkgs; [
    python3Packages.requests
    yt-dlp
    mpv

    # System monitoring
    btop
    htop

    # File search & navigation
    ripgrep
    fd
    fzf

    # File viewing & formatting
    bat
    eza
    jq

    # Compression / extraction
    unzip
    unrar
    p7zip

    # Networking
    wget2
    curl

    # System info
    fastfetch
  ];
}
