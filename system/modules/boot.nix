{
  pkgs,
  lib,
  ...
}: {
  boot.loader.timeout = lib.mkForce 10;

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
