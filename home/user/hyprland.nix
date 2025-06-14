{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    waybar.enable = true;
  };

  services = {
    dunst = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {accent = "mauve";};
      };
      settings.global.icon_path = lib.mkAfter ":${config.home.profileDirectory}/share/icons/${config.services.dunst.iconTheme.name}/${config.services.dunst.iconTheme.size}/panel";
    };
    hypridle.enable = true;
    swww.enable = true;
    wlsunset = {
      enable = true;
      latitude = 37.057291;
      longitude = -122.021501;
    };
  };

  home.packages = with pkgs; [
    (rofi.override {plugins = [pkgs.rofi-calc];})
    libnotify
  ];
}
