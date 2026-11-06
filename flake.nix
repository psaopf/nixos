{
  description = "p's NixOS machines (desktop + laptop)";

  inputs = {
    # Must match the channel you're on today (check: sudo nix-channel --list).
    # nixos-unstable assumed; for stable use nixos-26.05 here and release-26.05 below.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      # Config name must equal networking.hostName so a bare
      # `nixos-rebuild switch --flake /etc/nixos` picks the right one.
      mkHost = name: nixpkgs.lib.nixosSystem {
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/${name}
        ];
      };
    in {
      nixosConfigurations = {
        desktop = mkHost "desktop";
        laptop  = mkHost "laptop";
      };
    };
}
