{ config, lib, ... }: {
  flake.modules.nixos.default = {
    imports = builtins.attrValues (builtins.removeAttrs config.flake.modules.nixos [ "default" ]);
  };
}
