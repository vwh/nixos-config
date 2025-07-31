# OBS Studio configuration.

{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      input-overlay
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
