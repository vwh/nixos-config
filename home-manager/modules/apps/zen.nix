# Zen Browser configuration.

{
  inputs,
  ...
}:

{
  imports = [
    inputs.zen-browser.homeModules.default
  ];

  programs.zen-browser = {
    enable = true;

    # Policies for enhanced privacy and security
    policies = {
      # Disable telemetry and data collection
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFeedbackCommands = true;

      # Privacy settings
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      # Disable automatic updates and checks
      DisableAppUpdate = true;
      DontCheckDefaultBrowser = true;

      # Login and autofill settings
      OfferToSaveLogins = false;
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;

      # Remove default bookmarks
      NoDefaultBookmarks = true;

      # Extension settings
      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };

        # Dark Reader
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };

        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      # Preferences
      Preferences = {
        # Disable tab warnings
        "browser.tabs.warnOnClose" = false;
        "browser.tabs.warnOnOpen" = false;

        # Enable hardware acceleration
        "media.hardware-video-decoding.enabled" = true;

        # Better scrolling
        "general.smoothScroll" = true;

        # Disable webRTC leak protection (optional)
        "media.peerconnection.enabled" = false;
      };
    };

    # Profile configuration with containers and spaces
    profiles."default" = {
      # Force containers and spaces to be declarative
      containersForce = true;
      spacesForce = true;

      # Container configuration
      containers = {
        Personal = {
          color = "purple";
          icon = "fingerprint";
          id = 1;
        };

        Work = {
          color = "blue";
          icon = "briefcase";
          id = 2;
        };

        Shopping = {
          color = "yellow";
          icon = "cart";
          id = 3;
        };

        Social = {
          color = "red";
          icon = "circle";
          id = 4;
        };
      };

      # Spaces configuration
      spaces = {
        "Personal" = {
          id = "c6de089c-410d-4206-961d-ab11f988d40a";
          position = 1000;
          icon = "🏠";
          container = 1;
        };

        "Work" = {
          id = "cdd10fab-4fc5-494b-9041-325e5759195b";
          position = 2000;
          icon = "💼";
          container = 2;
        };

        "Shopping" = {
          id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
          position = 3000;
          icon = "🛒";
          container = 3;
        };

        "Social" = {
          id = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
          position = 4000;
          icon = "👥";
          container = 4;
        };
      };
    };
  };
}
