{pkgs, ...}: {
  home.packages = with pkgs; [
    (catppuccin.override {
      accent = "mauve";
      variant = "mocha";
      themeList = ["bat" "btop"];
    })
  ];

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;

    gtk.enable = true;
    hyprcursor = {
      enable = true;
      size = 24;
    };
  };

  catppuccin = {
    bat.enable = true;
    btop.enable = true;
    dunst.enable = true;
    fzf.enable = true;
    yazi.enable = true;
  };
}
