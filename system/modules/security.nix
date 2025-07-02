{...}: {
  security.polkit.enable = true;
  security.pam.services.hyprlock = {}; # so hyprlock can authenticate

  services.gnome.gnome-keyring.enable = true;

  programs = {
    fuse.userAllowOther = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
    };
  };
}
