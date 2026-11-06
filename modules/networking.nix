{ config, pkgs, ... }:
{
  ### NETWORKING ###
  # networking.hostName is set per host in hosts/*/default.nix

  networking.networkmanager.enable = true;

  ### LOCALE / TIME ###

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
}
