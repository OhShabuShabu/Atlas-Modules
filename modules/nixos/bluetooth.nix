{ lib, ... }: {
  flake.modules.nixos.bluetooth = { pkgs, lib, config, ... }: {
    options.yorha.modules.bluetooth = {
      enable = lib.mkEnableOption "Bluetooth support with Blueman";
    };

    config = lib.mkIf config.yorha.modules.bluetooth.enable {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings.General.Experimental = true;
      };

      services.blueman.enable = true;

      environment.systemPackages = with pkgs; [
        bluez
        bluez-tools
      ];
    };
  };
}
