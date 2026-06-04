{ lib, ... }: {
  flake.modules.homeManager.tools = { pkgs, lib, config, ... }: {
    options.yorha.modules.tools = {
      enable = lib.mkEnableOption "core CLI utilities";
    };

    config = lib.mkIf config.yorha.modules.tools.enable {
      home.packages = with pkgs; [
        python3Packages.requests
        yt-dlp
        mpv

        btop
        htop

        ripgrep
        fd
        fzf

        bat
        eza
        jq

        unzip
        unrar
        p7zip

        wget2
        curl

        fastfetch
      ];
    };
  };
}
