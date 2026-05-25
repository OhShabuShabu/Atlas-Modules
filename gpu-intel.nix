{ lib, ... }:

{
  # Load i915 in initrd so Plymouth shows KMS at native resolution during LUKS prompt.
  # Only the matching GPU's firmware gets bundled — keeps initrd small for /boot.
  boot.initrd.kernelModules = [ "i915" ];
  boot.initrd.availableKernelModules = [ "i915" ];
}
