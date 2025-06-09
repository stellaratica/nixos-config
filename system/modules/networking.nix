{...}: {
  networking = {
    hostName = "silly-willy"; # duh
    networkmanager.enable = true; # duh
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
