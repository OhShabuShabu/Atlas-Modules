# ============================================================================
# MODULE: gpu-amd
# CATEGORY: hardware
# VERSION: 1.0.0
# TAGS: gpu amd initrd plymouth
# DEPS: none
# INFO: Load amdgpu in initrd for Plymouth KMS at native resolution
# ============================================================================
{ lib, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.initrd.availableKernelModules = [ "amdgpu" ];
}
