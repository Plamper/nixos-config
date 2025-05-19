{
  # Pipewire Setup
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    extraConfig.pipewire."10-clock-rate"."context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.allowed-rates" = [
        44100
        48000
        # expedition 33 bug
        88200
        96000
        176400
        192000
        352800
        384000
        705600
        768000
      ];
    };
  };
}
