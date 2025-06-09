{...}: {
  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font Mono";
    settings = {
      # vim:ft=kitty

      ## name:     Catppuccin Kitty Mocha
      ## author:   Catppuccin Org
      ## license:  MIT
      ## upstream: https://github.com/catppuccin/kitty/blob/main/themes/mocha.conf
      ## blurb:    Soothing pastel theme for the high-spirited!

      # The basic colors
      foreground = "#cdd6f4";
      background = "#1e1e2e";
      selection_foreground = "#1e1e2e";
      selection_background = "#f5e0dc";

      # Cursor colors
      cursor = "#f5e0dc";
      cursor_text_color = "#1e1e2e";

      # URL underline color when hovering with mouse
      url_color = "#f5e0dc";

      # Kitty window border colors
      active_border_color = "#b4befe";
      inactive_border_color = "#6c7086";
      bell_border_color = "#f9e2af";

      # OS Window titlebar colors
      wayland_titlebar_color = "system";
      macos_titlebar_color = "system";

      # Tab bar colors
      active_tab_foreground = "#11111b";
      active_tab_background = "#cba6f7";
      inactive_tab_foreground = "#cdd6f4";
      inactive_tab_background = "#181825";
      tab_bar_background = "#11111b";

      # Colors for marks (marked text in the terminal)
      mark1_foreground = "#1e1e2e";
      mark1_background = "#b4befe";
      mark2_foreground = "#1e1e2e";
      mark2_background = "#cba6f7";
      mark3_foreground = "#1e1e2e";
      mark3_background = "#74c7ec";

      # The 16 terminal colors

      # black
      color0 = "#45475a";
      color8 = "#585b70";

      # red
      color1 = "#f38ba8";
      color9 = "#f582a0";

      # green
      color2 = "#a6e3a1";
      color10 = "#95e096";

      # yellow
      color3 = "#f9e2af";
      color11 = "#f6de9d";

      # blue
      color4 = "#89b4fa";
      color12 = "#83aefe";

      # magenta
      color5 = "#f5c2e7";
      color13 = "#f8b9e6";

      # cyan
      color6 = "#94e2d5";
      color14 = "#7be0d2";

      # white
      color7 = "#a6adc8";
      color15 = "#bac2de";

      cursor_trail = "1";

      window_padding_width = "10";
    };
  };
}
