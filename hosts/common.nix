{ config, pkgs, ... }:

# Everything both machines share. Per-host stuff lives in hosts/<name>/default.nix.
{
  imports = [
    ../modules/boot.nix
    ../modules/desktop.nix
    ../modules/audio.nix
    ../modules/networking.nix
    ../modules/users.nix
    ../modules/packages.nix
    ../modules/shell.nix
    ../modules/home.nix
    ../modules/nix.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Prevents the "stateVersion not set" warning on every rebuild.
  system.stateVersion = "26.05";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.p.imports = [
      ../modules/vscode.nix
    ];
  };
}
