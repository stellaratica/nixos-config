let
  configDir = ../config;
in {
  home.file = {
    ".config/hypr".source = "${configDir}/hypr";
    ".config/waybar".source = "${configDir}/waybar";
    ".config/rofi".source = "${configDir}/rofi";
    ".config/fastfetch".source = "${configDir}/fastfetch";
  };
}
