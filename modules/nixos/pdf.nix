{ lib, ... }: {
  flake.modules.nixos.pdf = { pkgs, lib, config, ... }: {
    options.yorha.modules.pdf = {
      enable = lib.mkEnableOption "PDF and document tools";
    };

    config = lib.mkIf config.yorha.modules.pdf.enable {
      environment.systemPackages = with pkgs; [
        zathura evince pdfarranger poppler_utils qpdf pandoc tesseract
      ];
    };
  };
}
