{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    # Core dev tools
    git
    gcc
    gnumake
    cmake
    bun

    # Language runtimes
    nodejs
    python3
    rustup
    go

    # Editors / IDEs
    neovim
    vscodium

    # AI coding assistants
    opencode
    claude-code

    # CLI productivity
    ripgrep
    fd
    fzf
    bat
    eza
    jq
    btop
    htop

    # Dev utilities
    gh
    lazygit
    tmux
    delta
    nil
    alejandra
  ];

  home.sessionPath = [ "$HOME/.local/bin" "$HOME/go/bin" ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "bat";
    BAT_THEME = "Dracula";
  };

  home.activation.setupNvim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "$HOME/.config/nvim" ]; then
      ${pkgs.git}/bin/git clone https://github.com/LazyVim/starter.git "$HOME/.config/nvim"
      ${pkgs.gnused}/bin/sed -i 's/--filter=blob:none //' "$HOME/.config/nvim/lua/config/lazy.lua"
    fi
  '';
}
