{
  config,
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
      package = pkgs.btop-rocm;
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

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-gstreamer
        obs-vkcapture
      ];
    };

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

    swappy = {
      enable = true;
      settings = {
        Default = {
          save_dir = "$HOME/Pictures/Screenshots/";
        };
      };
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

    zsh.dotDir = "${config.xdg.configHome}/zsh";
  };
}
