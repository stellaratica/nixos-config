{...}: {
  security.polkit.enable = true;
  security.pam.services.hyprlock = {}; # so hyprlock can authenticate

  services.gnome.gnome-keyring.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };
}
