{ config, pkgs, ... }:
{
  ### GPU (NVIDIA RTX 3060 Ti) ###

  # LTS kernel so the production driver branch builds (zen 7.2.x was too new).
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Wine/Proton 32-bit titles
  };

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;
    open = false;                    # proprietary module; true = open kernel module
    modesetting.enable = true;       # required for Wayland / proper VT handling
    powerManagement.enable = false;  # desktop: no suspend/resume power mgmt needed
    nvidiaSettings = true;
    nvidiaPersistenced = true;       # keeps driver state loaded, avoids init latency
  };

  # Coolbits 12 = fan control (4) + overclocking (8). X11 only.
  services.xserver.screenSection = ''
    Option "Coolbits" "12"
  '';

  programs.gamemode.enable = true;
}
