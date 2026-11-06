{ config, pkgs, ... }:
{
  ### BOOT / KERNEL (shared) ###
  # (boot.initrd.systemd.enable / boot.initrd.verbose removed: scripted initrd is gone,
  #  systemd initrd is the only one now.)
  # Per-host (see hosts/*/default.nix): loader timeout, kernel package,
  # sched_ext, power daemon, GPU initrd modules.

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.graceful = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=0"
    "systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.consoleLogLevel = 0;

  boot.plymouth.enable = true; # gives a clean splash screen instead of a wall of text

  ### PERFORMANCE ###

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  services.fstrim.enable = true;
}
