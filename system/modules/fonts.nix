{pkgs, ...}: {
  # fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
  fonts = {
    # only use fonts defined by the user
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      # noto (yes i know it's google im sorry)
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif

      # nerd fonts!
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
    ];

    # font defaults
    fontconfig.defaultFonts = {
      serif = ["Source Serif"];
      sansSerif = ["Source Sans"];
      monospace = ["JetBrainsMono Nerd Font"];
    };
  };
}
