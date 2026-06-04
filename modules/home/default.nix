{ config, lib, ... }: {
  flake.modules.homeManager.default = {
    imports = builtins.attrValues (builtins.removeAttrs config.flake.modules.homeManager [ "default" ]);
  };
}
