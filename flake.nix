{
  description = "YoRHa optional NixOS modules — gaming, privacy, dev tools, performance, and more";

  nixConfig = {
    extra-substituters = [ "https://yorha-modules.cachix.org" ];
    extra-trusted-public-keys = [ "yorha-modules.cachix.org-1:BbHyrb3n3/GQjAmi/ZFrqJQVGMsBRpGBYgIdBfUvEUo=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    flake-parts.url = "github:hercules-ci/flake-parts";
    haumea.url = "github:nix-community/haumea/v0.2.2";
    haumea.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./flake-modules/systems.nix
        ./flake-modules/flake-parts.nix
        ./flake-modules/per-system.nix
        ./flake-modules/lib.nix
        ./flake-modules/modules.nix
        ./modules/nixos/art.nix
        ./modules/nixos/bluetooth.nix
        ./modules/nixos/extras.nix
        ./modules/nixos/flatpak.nix
        ./modules/nixos/fonts.nix
        ./modules/nixos/gaming.nix
        ./modules/nixos/gpu-amd.nix
        ./modules/nixos/gpu-intel.nix
        ./modules/nixos/gpu-nvidia.nix
        ./modules/nixos/media.nix
        ./modules/nixos/minecraft.nix
        ./modules/nixos/notifications.nix
        ./modules/nixos/odysseus.nix
        ./modules/nixos/pdf.nix
        ./modules/nixos/performance.nix
        ./modules/nixos/privacy.nix
        ./modules/nixos/security.nix
        ./modules/nixos/shell.nix
        ./modules/nixos/virtualisation.nix
        ./modules/nixos/default.nix
        ./modules/home/dev.nix
        ./modules/home/tools.nix
        ./modules/home/default.nix
      ];
    };
}
