{
  pkgs,
  lib,
  ...
}: {
  boot.loader.timeout = lib.mkForce 10;

  boot.loader.systemd-boot.enable = lib.mkForce true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.lanzaboote = {
    enable = false;
    pkiBundle = "/var/lib/sbctl";
  };
}
