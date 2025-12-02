# Qdrant vector search engine configuration.
# This module enables and configures Qdrant for AI-powered code indexing.
# DISABLED: Removed due to high resource usage causing system lag

{ pkgs, ... }:

{

  # services.qdrant = {
  #   enable = true;
  # };

  # environment.systemPackages = with pkgs; [
  #   qdrant-web-ui # Optional: Web UI for Qdrant
  # ];
}
