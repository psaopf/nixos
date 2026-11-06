{ config, pkgs, ... }:
{
  ### ESP32 DEV (desktop only for now; add to a host's imports to enable) ###

  users.users.p.extraGroups = [ "dialout" ];

  # ESP32 OTA update allowance
  networking.firewall.allowedTCPPorts = [ 40000 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];  # mDNS, so the IDE can discover the board

  services.avahi = { enable = true; nssmdns4 = true; };
}
