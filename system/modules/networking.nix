{...}: {
  networking = {
    hostName = "cerulean"; # duh
    networkmanager.enable = true; # duh
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
