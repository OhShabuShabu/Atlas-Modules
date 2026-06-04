{ config, lib, ... }: {
  flake.nixosModules = config.flake.modules.nixos;

  flake.homeModules = config.flake.modules.homeManager;
}
