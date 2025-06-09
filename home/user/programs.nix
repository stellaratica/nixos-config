{
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  programs = {
    bat.enable = true; # cool cat with wings

    # task manager but for linux and it's also way better than task manager
    btop = {
      enable = true;
      settings = {
        theme_background = false;
      };
    };

    eza.enable = true; # ls alternative that i like a lot
    feh.enable = true; # image viewer (sexy)

    # fuzzy finder (very nice)
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    home-manager.enable = true; # ensure home-manager can use itself lol
    hyprlock.enable = true;
    librewolf.enable = true; # firefox fork
    obsidian.enable = true; # note-taking app

    # pretty spotify
    spicetify = {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        fullAppDisplay
        shuffle
      ];

      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };

    # terminal file manager (sexy)
    yazi = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings.manager = {
        show_hidden = true;
        sort_dir_first = true;
      };
    };
  };
}
