{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ./hardware-configuration.nix

    ../../modules/gpu.nix      # NVIDIA RTX 3060 Ti (also pins kernel to 6.12 LTS via mkForce)
    ../../modules/samba.nix
    ../../modules/nix_ld.nix
    ../../modules/esp32.nix
    ../../modules/webcam.nix
  ];

  networking.hostName = "desktop";

  # No boot menu delay on the desktop.
  boot.loader.timeout = 0;

  # Early KMS: load NVIDIA modules in initrd so plymouth splash hands off
  # cleanly instead of flickering/falling back to a generic framebuffer
  # resolution mid-boot. (hardware-configuration.nix sets this list to
  # empty by default — this list is additive, not a conflict.)
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  # Kernel package is set in modules/gpu.nix (linuxPackages_6_12, mkForce).
  # The old zen line in boot.nix was always overridden by it, so it's gone.

  services.scx.enable = true;
  services.scx.scheduler = "scx_lavd";

  # Secondary NTFS drive (desktop only); nofail keeps boot from hanging if it's disconnected
  fileSystems."/mnt/500GB" = {
    device = "/dev/disk/by-uuid/D62C9A422C9A1D95";
    fsType = "ntfs3";
    options = [ "force" "uid=1000" "gid=100" "nofail" ];
  };
}
