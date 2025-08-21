# Custom Warp terminal package that automatically downloads and wraps the latest AppImage

{
  pkgs,
  lib,
  stdenv,
  makeWrapper,
  ...
}:

let
  pname = "warp-terminal";
  version = "latest";

  appImageUrl = "https://app.warp.dev/download?package=appimage";

in
stdenv.mkDerivation {
  inherit pname version;

  # No source needed for this wrapper approach
  src = null;
  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = with pkgs; [
    appimage-run
    curl
  ];

  installPhase = ''
    # Create bin directory
    mkdir -p $out/bin

    # Create wrapper script that downloads and runs Warp with appimage-run
    cat > $out/bin/warp-terminal << 'EOF'
    #!/usr/bin/env bash

    # Create cache directory for AppImage
    CACHE_DIR="$HOME/.cache/warp-terminal-nix"
    APPIMAGE_PATH="$CACHE_DIR/Warp-x86_64.AppImage"

    mkdir -p "$CACHE_DIR"

    # Download AppImage if it doesn't exist or if it's older than 1 day
    if [ ! -f "$APPIMAGE_PATH" ] || [ $(find "$APPIMAGE_PATH" -mtime +1 2>/dev/null | wc -l) -gt 0 ]; then
      echo "Downloading latest Warp AppImage..."
      ${pkgs.curl}/bin/curl -L -o "$APPIMAGE_PATH.tmp" "${appImageUrl}" && \
        mv "$APPIMAGE_PATH.tmp" "$APPIMAGE_PATH" || {
        echo "Failed to download Warp AppImage"
        rm -f "$APPIMAGE_PATH.tmp"
        exit 1
      }
      chmod +x "$APPIMAGE_PATH"
    fi

    # Run the AppImage with appimage-run which provides all necessary libraries
    exec ${pkgs.appimage-run}/bin/appimage-run "$APPIMAGE_PATH" "$@"
    EOF

    chmod +x $out/bin/warp-terminal

    # Create convenient symlink
    ln -sf $out/bin/warp-terminal $out/bin/warp

    # Create desktop file
    mkdir -p $out/share/applications
    cat > $out/share/applications/warp-terminal.desktop << EOF
    [Desktop Entry]
    Name=Warp
    Comment=The terminal for the 21st century
    Exec=$out/bin/warp-terminal
    Icon=warp-terminal
    Type=Application
    Categories=System;TerminalEmulator;
    StartupWMClass=dev.warp.Warp
    Terminal=false
    StartupNotify=true
    EOF

    # Download Warp icon
    mkdir -p $out/share/icons/hicolor/512x512/apps
    ${pkgs.curl}/bin/curl -L -o $out/share/icons/hicolor/512x512/apps/warp-terminal.png \
      "https://raw.githubusercontent.com/warpdotdev/Warp/main/assets/warp-logo.png" || \
      ${pkgs.curl}/bin/curl -L -o $out/share/icons/hicolor/512x512/apps/warp-terminal.png \
      "https://avatars.githubusercontent.com/u/71840468?s=512&v=4" || \
      touch $out/share/icons/hicolor/512x512/apps/warp-terminal.png
  '';

  meta = with lib; {
    description = "Warp is a modern, Rust-based terminal with AI built in (auto-updating AppImage wrapper)";
    longDescription = ''
      Warp is a modern terminal built on Rust that makes you and your team more productive at coding and DevOps.
      It has built-in AI assistance, modern text editing features, and team collaboration tools.

      This package automatically downloads and runs the latest AppImage from Warp's release servers.
      The AppImage is cached locally and updated daily.
    '';
    homepage = "https://www.warp.dev/";
    downloadPage = "https://www.warp.dev/download";
    changelog = "https://docs.warp.dev/help/changelog";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    maintainers = [ ];
    mainProgram = "warp-terminal";
  };
}
