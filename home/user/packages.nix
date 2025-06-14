{pkgs, ...}: {
  home.packages = with pkgs; [
    # dev things
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
