{
  description = "Atlas optional NixOS modules — gaming, privacy, dev tools, performance, and more";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }: {
    nixosModules = {
      performance   = import ./modules/nixos/performance.nix;
      privacy       = import ./modules/nixos/privacy.nix;
      gaming        = import ./modules/nixos/gaming.nix;
      virtualisation = import ./modules/nixos/virtualisation.nix;
      minecraft     = import ./modules/nixos/minecraft.nix;
      flatpak       = import ./modules/nixos/flatpak.nix;
      bluetooth     = import ./modules/nixos/bluetooth.nix;
      pdf           = import ./modules/nixos/pdf.nix;
      art           = import ./modules/nixos/art.nix;
      extras        = import ./modules/nixos/extras.nix;

      gpu-amd       = import ./modules/nixos/gpu-amd.nix;
      gpu-intel     = import ./modules/nixos/gpu-intel.nix;
      gpu-nvidia    = import ./modules/nixos/gpu-nvidia.nix;

      security      = import ./modules/nixos/security.nix;
      shell         = import ./modules/nixos/shell.nix;
      fonts         = import ./modules/nixos/fonts.nix;
      media         = import ./modules/nixos/media.nix;

      default = import ./modules/nixos/default.nix;
    };

    homeModules = {
      dev   = import ./modules/home/dev.nix;
      tools = import ./modules/home/tools.nix;

      default = import ./modules/home/default.nix;
    };
  };
}
