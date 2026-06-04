{ lib, ... }: {
  flake.modules.homeManager.dev = { pkgs, lib, config, ... }: {
    options.yorha.modules.dev = {
      enable = lib.mkEnableOption "development tools";
    };

    config = lib.mkIf config.yorha.modules.dev.enable {
      home.packages = with pkgs; [
        neovim
        vscodium
        bun
        opencode
        nodejs
        nodePackages.typescript
        nodePackages.prettier
        nodePackages.eslint
        git
        gh
        lazygit
        delta
      ];
    };
  };
}
