# SOPS-Nix configuration for encrypted secrets management.

{ inputs, user, ... }:

{
  # Import the SOPS NixOS module
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml; # Path to encrypted secrets file (relative to this module)
    defaultSopsFormat = "yaml"; # Format of the secrets file
    validateSopsFiles = true; # Enable SOPS file validation

    # Age encryption key configuration
    age = {
      keyFile = "/home/${user}/.config/sops/age/keys.txt"; # Location of Age private key
      generateKey = false; # Don't auto-generate keys (use just sops-setup)
    };
  };

  sops.secrets.zai_api_key = {
    owner = user; # Allow user to read the secret
    mode = "0440"; # Readable by owner and group
  };
}
