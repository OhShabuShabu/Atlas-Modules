# ============================================================================
# MODULE: shell
# CATEGORY: system
# VERSION: 1.0.0
# TAGS: shell zsh bash fish terminal
# DEPS: none
# INFO: Interactive shell customization with zsh and plugins
# ============================================================================
{ config, pkgs, lib, ... }:

let
  cfg = config.atlas.modules.shell;
in {
  options.atlas.modules.shell = {
    enable = lib.mkEnableOption "shell customization";
    defaultShell = lib.mkOption {
      type = lib.types.str;
      default = "zsh";
      description = "Default user shell (zsh, bash, or fish)";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
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

    users.defaultUserShell = pkgs.zsh;

    environment.systemPackages = with pkgs; [
      starship
      zoxide
      thefuck
    ];
  };
}
