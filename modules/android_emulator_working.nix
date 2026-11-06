{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

let
  lib = pkgs.lib;

  # Try each candidate attribute path in order; use the first that evaluates.
  pick = candidates:
    let
      tryOne = n:
        let
          path = lib.splitString "." n;
          r = builtins.tryEval (
            if lib.hasAttrByPath path pkgs
            then lib.getAttrFromPath path pkgs
            else throw "missing"
          );
        in if r.success then [ r.value ] else null;
      results = lib.filter (x: x != null) (map tryOne candidates);
    in
      if results == []
      then lib.warn "android-emulator-env: none of [${toString candidates}] found, skipping" []
      else lib.head results;

  # Candidates for X11-style libs: top-level lowercase, xorg.<Name>, top-level <Name>
  x = n: [ (lib.toLower n) "xorg.${n}" n ];

  groups = [
    # Core runtime
    [ "glibc" ] [ "zlib" ] [ "zstd" ] [ "expat" ] [ "libpng" ] [ "libjpeg" ]
    [ "libffi" ] [ "openssl" ] [ "stdenv.cc.cc.lib" ] [ "ncurses" ]
    [ "libunwind" ] [ "pcre2" ] [ "glib" ] [ "libsndfile" ] [ "bzip2" ] [ "xz" ]

    # X11 / Qt xcb plugin
    (x "libX11") (x "libXext") (x "libXrender") (x "libXtst") (x "libXi")
    (x "libXrandr") (x "libXfixes") (x "libXcursor") (x "libXcomposite")
    (x "libXdamage") (x "libXinerama") (x "libXScrnSaver") (x "libXxf86vm")
    (x "libSM") (x "libICE") (x "libxkbfile") (x "libxshmfence")
    [ "libxcb-util" "xcb-util" "xorg.xcbutil" ]
    [ "libxcb-image" "xorg.xcbutilimage" ]
    [ "libxcb-keysyms" "xorg.xcbutilkeysyms" ]
    [ "libxcb-render-util" "xorg.xcbutilrenderutil" ]
    [ "libxcb-wm" "xorg.xcbutilwm" ]
    [ "libxcb-cursor" "xorg.xcbutilcursor" ]
    [ "libxcb" "xorg.libxcb" ] [ "libxkbcommon" ]

    # Graphics / Vulkan / GL
    [ "libdrm" ] [ "libgbm" ] [ "mesa" ] [ "libGL" ] [ "libglvnd" ] [ "libGLU" ]
    [ "vulkan-loader" ] [ "vulkan-tools" ] [ "wayland" ]

    # Toolkit / fonts
    [ "gtk3" ] [ "gdk-pixbuf" ] [ "cairo" ] [ "pango" ] [ "atk" ]
    [ "fontconfig" ] [ "freetype" ] [ "dejavu_fonts" ]

    # Audio
    [ "alsa-lib" ] [ "libpulseaudio" ] [ "pipewire" ]

    # System
    [ "dbus" ] [ "systemd" ] [ "udev" ] [ "nspr" ] [ "nss" ] [ "libuuid" ]
    [ "libbsd" ] [ "cacert" ] [ "coreutils" ] [ "util-linux" ] [ "procps" ]
    [ "which" ] [ "file" ]
  ];
in
(pkgs.buildFHSEnv {
  name = "android-emulator-env";
  targetPkgs = _: lib.concatMap pick groups;

  profile = ''
    export LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib:$LD_LIBRARY_PATH
    export ANDROID_SDK_ROOT=$HOME/Android/Sdk
    export QT_QPA_PLATFORM=xcb
  '';

  runScript = "bash";
}).env