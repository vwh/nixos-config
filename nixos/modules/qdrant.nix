# Qdrant vector search engine configuration.
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
