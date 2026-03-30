{
  pkgs,
  lib,
  ...
}: {
  boot.loader.timeout = lib.mkForce 10;

  boot.loader.systemd-boot.enable = lib.mkForce true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.lanzaboote = {
    # enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  boot.plymouth = {
    enable = true;
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = ["cuts_alt" "seal_3"];
      })
    ];
    theme = "cuts_alt";
  };
}
