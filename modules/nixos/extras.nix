{ lib, ... }: {
  flake.modules.nixos.extras = { pkgs, lib, config, ... }: {
    options.yorha.modules.extras = {
      enable = lib.mkEnableOption "extra tools (Ollama ROCm, animated wallpapers)";
    };

    config = lib.mkIf config.yorha.modules.extras.enable {
      environment.systemPackages = with pkgs; [
        ollama-rocm
        linux-wallpaperengine
        mpvpaper
      ];
    };
  };
}
