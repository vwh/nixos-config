# OBS Studio configuration.

{ pkgsStable, ... }:

{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgsStable.obs-studio-plugins; [
      input-overlay
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
