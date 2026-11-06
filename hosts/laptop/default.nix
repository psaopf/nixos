{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop";

  # Safety net: 3-second timeout allows rollback if an update fails
  boot.loader.timeout = 3;

  # Standard kernel for better power management and C-state transitions on laptops
  boot.kernelPackages = pkgs.linuxPackages;

  # Native Intel power management (SpeedStep / HWP)
  services.power-profiles-daemon.enable = true;

  # sched_ext off: saves CPU overhead on the 2-core / 4-thread processor (scx is off by default)
}
