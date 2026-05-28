# ============================================================================
# MODULE: gpu-intel
# CATEGORY: hardware
# VERSION: 1.0.0
# TAGS: gpu intel initrd plymouth
# DEPS: none
# INFO: Load i915 in initrd for Plymouth KMS at native resolution
# ============================================================================
{ lib, ... }:

{
  boot.initrd.kernelModules = [ "i915" ];
  boot.initrd.availableKernelModules = [ "i915" ];
}
