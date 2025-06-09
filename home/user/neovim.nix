{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      astrocore
      astrolsp
      astroui
    ];
    viAlias = true;
    vimAlias = true;
  };
}
