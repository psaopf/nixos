
{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

let
  androidEmulatorEnv = pkgs.buildFHSEnv
    (pkgs.appimageTools.defaultFhsEnvArgs // {
      name = "android-emulator-env";

      targetPkgs = pkgs: with pkgs; [
        # Android emulator runtime
        glibc
        zlib
        expat
        libpng
        stdenv.cc.cc.lib
        nspr
        nss
        libuuid
        libbsd
        dbus
        systemd
        cacert

        # X11 libraries
        xorg.libX11
        xorg.libXext
        xorg.libXrender
        xorg.libXtst
        xorg.libXi
        xorg.libXrandr
        xorg.libXfixes
        xorg.libXcursor
        xorg.libXcomposite
        xorg.libXdamage
        xorg.libxkbfile
        xorg.libXinerama
        xorg.libXft
        xorg.libXxf86vm
        xorg.libSM
        xorg.libICE
        libxcb
        libXScrnSaver
        libxkbcommon

        # Graphics
        libdrm
        libgbm
        mesa
        libGL
        vulkan-loader
        vulkan-tools

        # GTK, fonts and desktop integration
        gtk3
        gdk-pixbuf
        fontconfig
        freetype
        glib
        pango
        cairo
        atk
        at-spi2-atk
        at-spi2-core

        # Audio
        alsa-lib
        libpulseaudio

        # Utilities
        coreutils
        bash
        file
        findutils
        which
        procps
        util-linux
      ];

      runScript = "bash";
    });
in
androidEmulatorEnv.env
