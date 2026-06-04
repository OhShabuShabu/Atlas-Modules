{ lib, ... }: {
  flake.modules.nixos.shell = { pkgs, lib, config, ... }: {
    options.yorha.modules.shell = {
      enable = lib.mkEnableOption "shell customization";
      defaultShell = lib.mkOption {
        type = lib.types.enum [ "zsh" "bash" "fish" ];
        default = "zsh";
        description = "Default user shell (zsh, bash, or fish)";
      };
    };

    config = lib.mkIf config.yorha.modules.shell.enable {
      programs.zsh = lib.mkIf (config.yorha.modules.shell.defaultShell == "zsh") {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        autosuggestions.enable = true;
        ohMyZsh = {
          enable = true;
          plugins = [ "git" "sudo" "command-not-found" "extract" ];
          theme = "robbyrussell";
        };
      };

      programs.bash.enableCompletion = true;

      users.defaultUserShell = {
        zsh = pkgs.zsh;
        bash = pkgs.bashInteractive;
        fish = pkgs.fish;
      }.${config.yorha.modules.shell.defaultShell};

      environment.systemPackages = with pkgs; [
        starship
        zoxide
        thefuck
      ];
    };
  };
}
