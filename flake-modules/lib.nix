{ lib, inputs, ... }: {
  flake.lib = inputs.haumea.lib.load {
    src = ../lib;
    inputs = { inherit lib; };
  };
}
