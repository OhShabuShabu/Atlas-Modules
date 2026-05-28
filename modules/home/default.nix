# ============================================================================
# AUTO-IMPORT: All Home Manager modules in this directory
# ============================================================================
# Use `imports = [ atlas-modules.homeModules.default ];` to get all modules.
# ============================================================================
{ lib, ... }:

let
  dirContents = builtins.readDir ./.;
  moduleNames = builtins.filter (name: lib.hasSuffix ".nix" name) (
    builtins.attrNames dirContents
  );
  moduleFiles = builtins.map (name: ./. + "/${name}") moduleNames;
  filteredFiles = builtins.filter (f: f != ./default.nix) moduleFiles;
in {
  imports = filteredFiles;
}
