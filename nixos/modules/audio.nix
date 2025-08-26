# Audio configuration (PipeWire).
# This module configures the PipeWire audio system, which provides
# unified audio handling for applications using ALSA, PulseAudio, and JACK APIs.

{ config, lib, ... }:

{
  # Validation: Ensure PulseAudio and PipeWire don't conflict
  # This prevents configuration errors that could cause audio issues
  assertions = [
    {
      assertion = !(config.services.pulseaudio.enable && config.services.pipewire.enable);
      message = "PulseAudio and PipeWire cannot be enabled simultaneously";
    }
  ];

  # Enable real-time scheduling for audio applications
  security.rtkit.enable = true;

  services = {
    # Disable PulseAudio to avoid conflicts with PipeWire
    pulseaudio.enable = false;

    # PipeWire audio server configuration
    pipewire = {
      enable = true; # Enable PipeWire audio server
      alsa.enable = true; # Enable ALSA support for legacy applications
      alsa.support32Bit = true; # Enable 32-bit ALSA support
      pulse.enable = true; # Enable PulseAudio compatibility layer
      jack.enable = true; # Enable JACK audio connection kit support
    };
  };
}
