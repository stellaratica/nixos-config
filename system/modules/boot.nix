{
  pkgs,
  lib,
  ...
}: {
  boot.loader.timeout = lib.mkForce 10;

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_latest;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
