{pkgs, ...}: {
  home.packages = with pkgs; [
    # dev things
    dotnet-sdk_9
    jetbrains.rust-rover
    jetbrains.rider
    gcc
    go
    nil
    nodejs
    nodePackages.pnpm
    rustup

    # game stuff
    dolphin-emu
    itch
    parallel-launcher
    (prismlauncher.override {
      # Add libraries required by some mods
      additionalLibs = [at-spi2-atk cairo cups dbus expat glib libdrm libgbm libxkbcommon nspr nss pango xorg.libxcb xorg.libXcomposite xorg.libXdamage xorg.libXfixes];

      # Add Zulu jdks
      jdks = [
        jdk21
        jdk17
        jdk8
        zulu
        zulu17
        zulu8
      ];
    })
    ryujinx

    # utils
    aseprite
    brightnessctl
    bluetui
    iw
    keepassxc # password manager
    # playerctl
    pulseaudio
    pulsemixer
    ryzenadj # set stapm, etc. parameters
    wireshark
    wl-clipboard # dumbass forgot this earlier
  ];
}
