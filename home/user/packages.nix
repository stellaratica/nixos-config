{
  inputs,
  pkgs,
  ...
}:
let
  pkgs-stable = import inputs.nixpkgs-stable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
  pkgs-master = import inputs.nixpkgs-master {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  home.packages = with pkgs; [
    strawberry # music player
    davinci-resolve # video editor
    kdePackages.kdenlive # other video editor (hevc and aac support)
    vlc # video player

    # dev things
    dotnet-sdk_9
    jetbrains.idea
    jetbrains.rider
    gcc
    go
    nil
    nodejs
    pnpm
    python3
    rustup

    # game stuff
    dolphin-emu
    itch
    pkgs-stable.parallel-launcher
    (prismlauncher.override {
      # Add libraries required by some mods
      additionalLibs = [
        at-spi2-atk
        cairo
        cups
        dbus
        expat
        glib
        libdrm
        libgbm
        libxkbcommon
        nspr
        nss
        pango
        libxcb
        libXcomposite
        libXdamage
        libXfixes
      ];

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
    ryubing
    pkgs-master.sm64coopdx
    vintagestory # yay

    # utils
    pkgs-stable.aseprite
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
