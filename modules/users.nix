{ config, pkgs, ... }:
{
  ### USERS ###
  # Host-specific groups (e.g. dialout for ESP32) are added in their own modules.

  users.users.p = {
    isNormalUser = true;
    description = "p";
    extraGroups = [ "networkmanager" "wheel" "openrazer" "kvm" "adbusers" ];
  };
}
