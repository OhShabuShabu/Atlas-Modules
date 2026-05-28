# ============================================================================
# MODULE: minecraft
# CATEGORY: gaming
# VERSION: 1.0.0
# TAGS: minecraft prism launcher
# DEPS: gaming
# INFO: PrismLauncher, Blockbench, MCEdit-like region editor
# ============================================================================
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    prismlauncher
    blockbench
    mcaselector
  ];
}
