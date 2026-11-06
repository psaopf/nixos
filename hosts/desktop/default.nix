{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ./hardware-configuration.nix

    ../../modules/gpu.nix      # NVIDIA RTX 3060 Ti, 6.12 LTS kernel, 32-bit GL, gamemode
    ../../modules/samba.nix
    ../../modules/nix_ld.nix
    ../../modules/esp32.nix
    ../../modules/webcam.nix   # defines my.webcam.enable (off by default)
  ];

  networking.hostName = "desktop";

  # Webcam v4l2 tuning on plug-in. Set to true to turn it on.
  my.webcam.enable = false;

  # Desktop-only apps (shared ones are in modules/packages.nix)
  environment.systemPackages = with pkgs; [
    android-studio

    # gaming
    heroic
    mangohud
    wineWow64Packages.stable
    umu-launcher
  ];

  # No boot menu delay on the desktop.
  boot.loader.timeout = 0;

  # Early KMS: load NVIDIA modules in initrd so plymouth splash hands off
  # cleanly instead of flickering/falling back to a generic framebuffer
  # resolution mid-boot. (hardware-configuration.nix sets this list to
  # empty by default — this list is additive, not a conflict.)
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  services.scx.enable = true;
  services.scx.scheduler = "scx_lavd";

  # Secondary NTFS drive (desktop only); nofail keeps boot from hanging if it's disconnected
  fileSystems."/mnt/500GB" = {
    device = "/dev/disk/by-uuid/D62C9A422C9A1D95";
    fsType = "ntfs3";
    options = [ "force" "uid=1000" "gid=100" "nofail" ];
  };
}
