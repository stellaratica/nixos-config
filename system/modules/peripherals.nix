{...}: {
  # ================ Audio (PipeWire) ================= #

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  security.rtkit.enable = true;

  services.pulseaudio.enable = false;

  # ================     Bluetooth     ================ #

  hardware.bluetooth.enable = true; # im a simple chap

  # ================ Keyboard =================#
  services.keyd = {
    enable = true;
    keyboards.dumb-keyboard = {
      ids = ["04e8:7021"];
      settings = {
        main = {
          homepage = "esc";
        };
      };
    };
  };

  # ================       Misc        ================ #

  services = {
    printing.enable = true; # CUPS support
    geoclue2.enable = true; # geolocation
  };
}
