# ============================================================================
# lib/default.nix — Shared library functions for Atlas-Modules
# ============================================================================
{ lib, ... }:

{
  # Common utility: wrap a package list conditionally
  optionals = lib.optionals;
  optionalString = lib.optionalString;

  # Asset paths relative to repo root
  assets = {
    gaming.millennium = ./assets/gaming/millennium;
    privacy.mullvadbrowser = ./assets/privacy/mullvadbrowser;
  };
}
