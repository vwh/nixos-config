# Ollama service configuration for local AI models and embeddings.

{ pkgs, ... }:

{
  # Enable Ollama service
  services.ollama = {
    enable = true;
  };

  # Add Ollama to system packages for CLI tools
  environment.systemPackages = with pkgs; [
    ollama # Ollama CLI and service
  ];
}
