{ lib, ... }: {
  flake.modules.nixos.art = { pkgs, lib, config, ... }: {
    options.yorha.modules.art = {
      enable = lib.mkEnableOption "digital art and creative tools";
    };

    config = lib.mkIf config.yorha.modules.art.enable {
      environment.systemPackages = with pkgs; [
        krita
        inkscape
        gimp
        obs-studio
      ];
    };
  };
}
