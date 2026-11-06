{ config, pkgs, ... }:
{
  ### PACKAGES ###

  #PERIPHERALS
  hardware.openrazer.enable = true;

  #MullVad
  services.mullvad-vpn.enable = true;

  #Dev
  users.users.p.extraGroups = [ "kvm" "adbusers" ];

  # 32-bit GL for Wine/Proton (desktop got this from gpu.nix; laptop had none)
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  environment.systemPackages = with pkgs; [
    # terminal
    ghostty
    btop

    # peripherals
    razergenie
    polychromatic
    openrgb
    cheese
    pkgs.v4l-utils

    # comms
    discord

    # dev
    python3
    ffmpeg
    android-studio
    android-tools
    steam-run-free

    #Media
    vlc

    # internet
    qbittorrent
    mullvad-vpn

    # Gaming
    heroic
    mangohud
    wineWow64Packages.stable
    umu-launcher

    #Tools
    flameshot

    # Office
    libreoffice-qt-fresh

  ];
}
