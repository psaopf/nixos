{ config, lib, pkgs, ... }:
let
  cfg = config.my.webcam;
in
{
  ### WEBCAM TUNING (Logitech, vendor 046d) ###
  # Off by default. Turn on in a host file with:  my.webcam.enable = true;

  options.my.webcam.enable = lib.mkEnableOption "fixed v4l2 tuning for the Logitech webcam on plug-in";

  config = lib.mkIf cfg.enable {
    services.udev.extraRules =
      let
        cam = pkgs.writeShellScript "webcam-tune" ''
          v=${pkgs.v4l-utils}/bin/v4l2-ctl
          sleep 2
          $v -d "$1" -c focus_automatic_continuous=0 -c white_balance_automatic=0 \
            -c auto_exposure=1 -c exposure_dynamic_framerate=1
          $v -d "$1" -c focus_absolute=0 -c white_balance_temperature=2300 \
            -c exposure_time_absolute=917 -c gain=10 -c brightness=128 \
            -c contrast=110 -c saturation=115 -c sharpness=150
        '';
      in
      ''
        ACTION=="add", SUBSYSTEM=="video4linux", ATTRS{idVendor}=="046d", ATTR{index}=="0", \
          RUN+="${pkgs.systemd}/bin/systemd-run --no-block ${cam} $devnode"
      '';
  };
}
