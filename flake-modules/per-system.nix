{ pkgs, ... }: {
  perSystem = { pkgs, ... }: {
    formatter = pkgs.nixpkgs-fmt;

    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        nixpkgs-fmt
        statix
        deadnix
        nix-doc
      ];
    };

    checks = { };

    packages.default = pkgs.runCommand "yorha-modules-doc" { } ''
      mkdir -p "$out"
      echo "YoRHa-Modules — imported via nixosModules, not built directly." > "$out/README"
    '';
  };
}
