{ config, pkgs, ... }:
{
  ### PACKAGES (both hosts) ###
  # Desktop-only apps live in hosts/desktop/default.nix.

  # Peripherals
  hardware.openrazer.enable = true;

  # Mullvad: daemon + GUI (gui.enable adds pkgs.mullvad-vpn to systemPackages)
  services.mullvad-vpn = {
    enable = true;
    gui.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # terminal
    ghostty
    btop

    # peripherals
    razergenie
    polychromatic
    openrgb
    cheese
    v4l-utils

    # comms
    discord

    # dev
    python3
    ffmpeg
    android-tools
    steam-run-free

    # media
    vlc

    # internet
    qbittorrent

    # tools
    flameshot

    # office
    libreoffice-qt
  ];
}
