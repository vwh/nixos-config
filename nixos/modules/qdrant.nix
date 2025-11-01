# Qdrant vector search engine configuration.
# This module enables and configures Qdrant for AI-powered code indexing.

{ pkgs, ... }:

{
  # Enable Qdrant service
  services.qdrant = {
    enable = true;
  };

  # Add Qdrant to system packages for CLI tools
  environment.systemPackages = with pkgs; [
    qdrant-web-ui # Optional: Web UI for Qdrant
  ];
}
