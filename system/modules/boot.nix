{
  inputs,
  lib,
  ...
}: let
  pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux".extend (final: prev: {
    adi1090x-plymouth-themes = prev.adi1090x-plymouth-themes.overrideAttrs (previousAttrs: {
      installPhase =
        previousAttrs.installPhase
        + ''
          find $out/share/plymouth/themes/ -name \*.script -exec sed -i 's/Window.GetX()/Window.GetX(0)/g' {} \;
          find $out/share/plymouth/themes/ -name \*.script -exec sed -i 's/Window.GetY()/Window.GetY(0)/g' {} \;
        '';
    });
  });
in {
  boot.loader.timeout = lib.mkForce 10;

  boot.loader.systemd-boot = {
    enable = lib.mkForce true;
    consoleMode = "max";
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.lanzaboote = {
    enable = false;
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
