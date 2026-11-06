{ config, pkgs, ... }:
let
  host = config.networking.hostName;
  edit = path: "sudo codium /etc/nixos/${path} --no-sandbox --user-data-dir /tmp";

  # r                 -> switch this machine
  # r desktop         -> switch if this IS the desktop, otherwise just build it (safe check)
  # r laptop test     -> explicit action: switch | boot | test | build | dry-activate
  r = pkgs.writeShellScriptBin "r" ''
    current=${host}
    target=''${1:-$current}

    if [ "$target" = "$current" ]; then
      action=''${2:-switch}
    else
      action=''${2:-build}
      echo "note: '$target' is not this machine ($current); default action is '$action'" >&2
    fi

    cd /tmp  # 'build' drops a ./result symlink in the cwd
    exec sudo nixos-rebuild "$action" --flake "/etc/nixos#$target"
  '';
in
{
  ### SHELL ###

  environment.systemPackages = [ r ];

  programs.bash.shellAliases = {
    e  = edit "hosts/${host}/default.nix";
    f  = edit "flake.nix";
    b  = edit "modules/boot.nix";
    g  = edit "modules/gpu.nix";
    d  = edit "modules/desktop.nix";
    n  = edit "modules/networking.nix";
    pk = edit "modules/packages.nix";
    h  = edit "modules/home.nix";
  };
}
