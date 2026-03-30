{
  programs.hyprland.enable = true;

  console.colors = [
      "1e1e2e"
      "f38ba8"
      "a6e3a1"
      "f9e2af"
      "89b4fa"
      "f5c2e7"
      "94e2d5"
      "a6adc8"
      "585b70"
      "f582a0"
      "95e096"
      "f6de9d"
      "83aefe"
      "f8b9e6"
      "7be0d2"
      "bac2de"
  ];

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "colormix";
      bigclock = "en";
      colormix_col1 = "0x0005";
      colormix_col2 = "0x0006";
      colormix_col3 = "0x0001";
    };
  };
}
