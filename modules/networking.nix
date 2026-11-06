{ config, pkgs, ... }:
{
  ### NETWORKING ###

  # networking.hostName is set per host in hosts/*/default.nix
  # networking.wireless.enable = true; # using NetworkManager instead
  networking.networkmanager.enable = true;

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # services.openssh.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  ### LOCALE / TIME ###

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";
}
