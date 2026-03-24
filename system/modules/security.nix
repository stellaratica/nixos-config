{...}: {
  security.polkit.enable = true;
  security.pam = {
    services.hyprlock = {}; # so hyprlock can authenticate
    loginLimits = [
      {
        domain = "*";
        type = "hard";
        item = "nofile";
        value = "2097152";
      }
    ];
  };

  services.gnome.gnome-keyring.enable = true;

  programs = {
    fuse.userAllowOther = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
    };
  };
}
