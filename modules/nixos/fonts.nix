{ lib, ... }: {
  flake.modules.nixos.fonts = { pkgs, lib, config, ... }: {
    options.yorha.modules.fonts = {
      enable = lib.mkEnableOption "font configuration";
      nerdy = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Include Nerd Fonts patched fonts";
      };
    };

    config = lib.mkIf config.yorha.modules.fonts.enable {
      fonts = {
        enableDefaultPackages = true;
        fontconfig = {
          enable = true;
          defaultFonts = {
            monospace = [ "JetBrainsMono Nerd Font" "FiraCode Nerd Font" ];
            sansSerif = [ "Inter" "Noto Sans" ];
            serif = [ "Noto Serif" ];
          };
        };
      };

      fonts.packages = with pkgs; [
        inter
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        jetbrains-mono
        fira-code
      ] ++ lib.optionals config.yorha.modules.fonts.nerdy [
        (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "NerdFontsSymbolsOnly" ]; })
      ];
    };
  };
}
