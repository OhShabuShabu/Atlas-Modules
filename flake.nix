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

      default = self.nixosModules.performance;
    };

    homeModules = {
      dev = import ./dev/dev.nix;
      tools = import ./tools.nix;

      default = self.homeModules.dev;
    };
  };
}
