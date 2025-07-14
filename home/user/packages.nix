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
    prismlauncher
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
