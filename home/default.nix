{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.spicetify-nix.homeManagerModules.spicetify
    ./user
  ];

  home.username = "stellaratica";
  home.homeDirectory = "/home/stellaratica";
  home.stateVersion = "24.11";
}
