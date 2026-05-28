# ============================================================================
# MODULE: gpu-nvidia
# CATEGORY: hardware
# VERSION: 1.0.0
# TAGS: gpu nvidia initrd plymouth
# DEPS: none
# INFO: Load nouveau in initrd for Plymouth KMS at native resolution
# ============================================================================
{ lib, ... }:

{
  boot.initrd.kernelModules = [ "nouveau" ];
  boot.initrd.availableKernelModules = [ "nouveau" ];
}
