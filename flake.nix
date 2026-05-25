{
  description = "Atlas optional NixOS modules — gaming, privacy, dev tools, and more";

  outputs = { self }: {
    nixosModules = {
      performance = import ./performance.nix;
      privacy = import ./privacy/privacy.nix;
      gaming = import ./gaming/gaming.nix;
      virtualisation = import ./virtualisation.nix;
      minecraft = import ./minecraft.nix;
      flatpak = import ./flatpak.nix;
      bluetooth = import ./bluetooth.nix;
      pdf = import ./pdf.nix;
      art = import ./art/art.nix;
      extras = import ./extras.nix;

      # GPU initrd modules — each includes only its own GPU's firmware
      # in initrd, keeping /boot from filling up. Installer auto-detects
      # hardware and downloads the matching module.
      gpu-amd    = import ./gpu-amd.nix;
      gpu-intel  = import ./gpu-intel.nix;
      gpu-nvidia = import ./gpu-nvidia.nix;

      default = self.nixosModules.performance;
    };

    homeModules = {
      dev = import ./dev/dev.nix;
      tools = import ./tools.nix;

      default = self.homeModules.dev;
    };
  };
}
