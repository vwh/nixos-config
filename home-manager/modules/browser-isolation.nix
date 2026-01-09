# Browser isolation with multiple profiles for different contexts.
# Provides isolated browser profiles for work, personal, and Tor browsing.

{
  home.file = {
    ".local/bin/browser-work" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # Work browser profile - isolated from personal browsing
        set -euo pipefail

        if ! command -v librewolf &>/dev/null; then
          echo "Error: librewolf is not installed" >&2
          exit 1
        fi

        PROFILE_DIR="$HOME/.librewolf-work"
        mkdir -p "$PROFILE_DIR"
        chmod 700 "$PROFILE_DIR"

        exec librewolf --profile "$PROFILE_DIR" --new-instance 2>/dev/null
      '';
    };

    ".local/bin/browser-work-tor" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # LibreWolf routed through Tor SOCKS proxy with persistent profile

        PROFILE_DIR="$HOME/.librewolf-work-tor"
        mkdir -p "$PROFILE_DIR"
        chmod 700 "$PROFILE_DIR"

        # Function to check if port is open using bash built-in
        check_port() {
          local host=$1
          local port=$2
          timeout 1 bash -c "cat < /dev/null > /dev/tcp/$host/$port" 2>/dev/null
        }

        # Check if Tor is available (try common ports)
        TOR_PORT=""
        if check_port 127.0.0.1 9150; then
          TOR_PORT="9150"  # Tor Browser's port
        elif check_port 127.0.0.1 9050; then
          TOR_PORT="9050"  # System Tor port
        else
          echo "Error: Tor SOCKS proxy not found on ports 9050 or 9150"
          echo ""
          echo "Please start Tor Browser or enable the Tor service:"
          echo "  sudo systemctl enable --now tor.service"
          echo ""
          echo "Then run browser-work-tor again."
          exit 1
        fi

        echo "Routing LibreWolf through Tor SOCKS proxy (127.0.0.1:$TOR_PORT)..."

        # Create user.js with Tor proxy settings (only if not exists)
        if [ ! -f "$PROFILE_DIR/user.js" ]; then
        cat > "$PROFILE_DIR/user.js" <<EOF
        // Tor SOCKS5 Proxy Configuration
        user_pref("network.proxy.type", 1);
        user_pref("network.proxy.socks", "127.0.0.1");
        user_pref("network.proxy.socks_port", $TOR_PORT);
        user_pref("network.proxy.socks_remote_dns", true);
        user_pref("network.proxy.socks_version", 5);

        // DNS Leak Prevention
        user_pref("network.dns.blockDotOnion", false);
        user_pref("network.http.sendRefererHeader", 0);
        user_pref("privacy.firstparty.isolate", true);
        user_pref("network.dns.disablePrefetch", true);
        user_pref("network.dns.disableIPv6", true);
        user_pref("network.http.speculative-parallel-limit", 0);
        user_pref("network.predictor.enabled", false);

        // Complete WebRTC Block
        user_pref("media.peerconnection.enabled", false);
        user_pref("media.peerconnection.ice.default_address_only", true);
        user_pref("media.peerconnection.ice.no_host", true);
        user_pref("media.peerconnection.ice.proxy_only", true);
        user_pref("media.navigator.enabled", false);
        user_pref("webgl.disabled", true);
        user_pref("dom.ipc.plugins.enabled", false);

        // Disable safe browsing (privacy leak)
        user_pref("browser.safebrowsing.downloads.enabled", false);
        user_pref("browser.safebrowsing.malware.enabled", false);
        user_pref("extensions.blocklist.enabled", false);
        EOF
                fi

                exec librewolf --profile "$PROFILE_DIR" --new-instance 2>/dev/null
      '';
    };

    ".local/bin/browser-tmp-tor" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # Temporary Tor browser - profile deleted on exit

        PROFILE_DIR="$(mktemp -d)"
        echo "Starting ephemeral Tor browser with profile: $PROFILE_DIR"
        echo "Profile will be deleted on exit"

        # Function to check if port is open using bash built-in
        check_port() {
          local host=$1
          local port=$2
          timeout 1 bash -c "cat < /dev/null > /dev/tcp/$host/$port" 2>/dev/null
        }

        # Check if Tor is available (try common ports)
        TOR_PORT=""
        if check_port 127.0.0.1 9150; then
          TOR_PORT="9150"  # Tor Browser's port
        elif check_port 127.0.0.1 9050; then
          TOR_PORT="9050"  # System Tor port
        else
          echo "Error: Tor SOCKS proxy not found on ports 9050 or 9150"
          echo ""
          echo "Please start Tor Browser or enable the Tor service:"
          echo "  sudo systemctl enable --now tor.service"
          echo ""
          echo "Then run browser-tmp-tor again."
          rm -rf "$PROFILE_DIR"
          exit 1
        fi

        echo "Routing LibreWolf through Tor SOCKS proxy (127.0.0.1:$TOR_PORT)..."

        trap "rm -rf '$PROFILE_DIR'" EXIT

        # Create user.js with Tor proxy settings (loaded on browser startup)
        cat > "$PROFILE_DIR/user.js" <<EOF
        // Tor SOCKS5 Proxy Configuration
        user_pref("network.proxy.type", 1);
        user_pref("network.proxy.socks", "127.0.0.1");
        user_pref("network.proxy.socks_port", $TOR_PORT);
        user_pref("network.proxy.socks_remote_dns", true);
        user_pref("network.proxy.socks_version", 5);

        // DNS Leak Prevention
        user_pref("network.dns.blockDotOnion", false);
        user_pref("network.http.sendRefererHeader", 0);
        user_pref("privacy.firstparty.isolate", true);
        user_pref("network.dns.disablePrefetch", true);
        user_pref("network.dns.disableIPv6", true);
        user_pref("network.http.speculative-parallel-limit", 0);
        user_pref("network.predictor.enabled", false);

        // Complete WebRTC Block
        user_pref("media.peerconnection.enabled", false);
        user_pref("media.peerconnection.ice.default_address_only", true);
        user_pref("media.peerconnection.ice.no_host", true);
        user_pref("media.peerconnection.ice.proxy_only", true);
        user_pref("media.navigator.enabled", false);
        user_pref("webgl.disabled", true);
        user_pref("dom.ipc.plugins.enabled", false);

        // Disable safe browsing (privacy leak)
        user_pref("browser.safebrowsing.downloads.enabled", false);
        user_pref("browser.safebrowsing.malware.enabled", false);
        user_pref("extensions.blocklist.enabled", false);
        EOF

        exec librewolf --profile "$PROFILE_DIR" --new-instance 2>/dev/null
      '';
    };

    ".local/bin/browser-personal" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        # Personal browser with Brave + Mullvad VPN protection
        # Uses background monitoring to survive VPN network changes
        set -euo pipefail

        if ! command -v brave &>/dev/null; then
          echo "Error: brave is not installed" >&2
          exit 1
        fi

        if ! command -v mullvad &>/dev/null; then
          echo "Error: mullvad is not installed" >&2
          exit 1
        fi

        PROFILE_DIR="$HOME/.brave-personal"
        mkdir -p "$PROFILE_DIR"
        chmod 700 "$PROFILE_DIR"

        # PID file for monitoring process
        PID_FILE="/tmp/brave-mullvad-monitor-$USER.pid"

        # Cleanup function
        cleanup() {
          if [ -f "$PID_FILE" ]; then
            MONITOR_PID=$(cat "$PID_FILE" 2>/dev/null || echo "")
            if [ -n "$MONITOR_PID" ] && kill -0 "$MONITOR_PID" 2>/dev/null; then
              kill "$MONITOR_PID" 2>/dev/null || true
            fi
            rm -f "$PID_FILE"
          fi
          echo "Monitor stopped"
        }

        # Trap signals for cleanup
        trap cleanup EXIT INT TERM

        # Connect to random Mullvad relay if disconnected
        if ! mullvad status 2>/dev/null | grep -q "^Connected"; then
          echo "Mullvad is disconnected. Connecting to random relay..."
          mullvad relay set location any >/dev/null 2>&1
          mullvad connect --wait >/dev/null 2>&1
          if mullvad status 2>/dev/null | grep -q "^Connected"; then
            echo "Connected to Mullvad VPN"
          else
            echo "Failed to connect to Mullvad VPN" >&2
            exit 1
          fi
        else
          echo "Mullvad VPN is already connected"
        fi

        # Start browser
        echo "Starting Brave browser with Mullvad protection..."
        brave --user-data-dir="$PROFILE_DIR" 2>/dev/null &
        BRAVE_PID=$!

        # Give browser time to start
        sleep 2

        if ! kill -0 $BRAVE_PID 2>/dev/null; then
          echo "Error: Failed to start Brave browser" >&2
          exit 1
        fi

        # Kill browser by killing all processes using the profile directory
        kill_browser() {
          pkill -f "brave.*$PROFILE_DIR" 2>/dev/null || true
          pkill -f "brave-wrapped.*$PROFILE_DIR" 2>/dev/null || true
        }

        # Start background monitoring process (survives VPN connection changes)
        (
          while kill -0 $BRAVE_PID 2>/dev/null; do
            if ! mullvad status 2>/dev/null | grep -q "^Connected"; then
              echo ""
              echo "WARNING: Mullvad VPN disconnected!"
              echo "Closing browser for your protection..."
              kill_browser
              break
            fi
            sleep 2
          done
          echo "Monitor: VPN disconnected, browser killed"
        ) &
        MONITOR_PID=$!
        echo $MONITOR_PID > "$PID_FILE"

        # Wait for browser to exit
        echo "Browser running (PID: $BRAVE_PID). Monitoring Mullvad (PID: $MONITOR_PID)..."
        echo "Press Ctrl+C to stop monitoring."
        wait $BRAVE_PID 2>/dev/null || true

        echo "Browser exited"
      '';
    };

    # Desktop files for wofi integration
    ".local/share/applications/browser-work.desktop" = {
      text = ''
        [Desktop Entry]
        Name=Browser (Work)
        Exec=browser-work
        Type=Application
        Icon=librewolf
        Categories=Network;WebBrowser;
      '';
    };

    ".local/share/applications/browser-personal.desktop" = {
      text = ''
        [Desktop Entry]
        Name=Browser (Personal)
        Exec=browser-personal
        Type=Application
        Icon=brave
        Categories=Network;WebBrowser;
      '';
    };

    ".local/share/applications/browser-work-tor.desktop" = {
      text = ''
        [Desktop Entry]
        Name=Browser (Work + Tor)
        Exec=browser-work-tor
        Type=Application
        Icon=librewolf
        Categories=Network;WebBrowser;
      '';
    };

    ".local/share/applications/browser-tmp-tor.desktop" = {
      text = ''
        [Desktop Entry]
        Name=Browser (Temporary + Tor)
        Exec=browser-tmp-tor
        Type=Application
        Icon=librewolf
        Categories=Network;WebBrowser;
      '';
    };
  };
}
