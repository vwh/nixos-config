# Nix package definition for prayerbar
# Maintainer: Onizuka893 <https://github.com/Onizuka893>

{ pkgs, ... }:

[
  (pkgs.rustPlatform.buildRustPackage rec {
    pname = "prayerbar";
    version = "unstable";

    src = pkgs.fetchFromGitHub {
      owner = "Onizuka893";
      repo = "prayerbar";
      rev = "5a0ae8f36e3f04ba207bddc648ea4079ff4ae410";
      sha256 = "sha256-ChW/O7rLU4lZT0Yt6a2JHCpxzQ12/0MyGd0OK291L/E=";
    };

    cargoHash = "sha256-3DWCeQnLNINq6dsD0C5xRAZOnkAGRlxOfXwIOwCxy3c=";

    meta = with pkgs.lib; {
      description = "A simple prayer time indicator for Waybar";
      homepage = "https://github.com/Onizuka893/prayerbar";
      license = licenses.unfree;
    };
  })
]
