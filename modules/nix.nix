{ config, pkgs, ... }:
{
  ### NIX STORE MAINTENANCE ###

  nix.settings.auto-optimise-store = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
