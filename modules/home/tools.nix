# ============================================================================
# MODULE: tools
# CATEGORY: tools
# VERSION: 1.1.0
# TAGS: media downloader tools utilities
# DEPS: none
# INFO: Core CLI utilities: yt-dlp, mpv, btop, ripgrep, bat, and more
# ============================================================================
{ pkgs, ... }:

{
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
