# ============================================================================
# MODULE: dev
# CATEGORY: development
# VERSION: 2.0.0
# TAGS: dev neovim vscode editor bun opencode
# DEPS: none
# INFO: Development tools: Neovim with LazyVim, VSCodium, bun, opencode
# ============================================================================
{ pkgs, ... }:

{
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
    github-cli
  ];
}
