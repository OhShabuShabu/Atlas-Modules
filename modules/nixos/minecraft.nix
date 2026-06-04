{ lib, ... }: {
  flake.modules.nixos.minecraft = { pkgs, lib, config, ... }: {
    options.yorha.modules.minecraft = {
      enable = lib.mkEnableOption "Minecraft development tools";
    };

    config = lib.mkIf config.yorha.modules.minecraft.enable {
      environment.systemPackages = with pkgs; [
        prismlauncher
        blockbench
        mcaselector
      ];
    };
  };
}
