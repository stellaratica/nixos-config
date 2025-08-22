{inputs, ...}: {
  imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  services = {
    clipse.enable = true;
    flameshot = {
      enable = true;
      settings = {
        General = {
          disabledGrimWarning = true;
          showHelp = false;
          showSidePanelButton = false;
          showDesktopNotification = false;
        };
      };
    };
    flatpak.packages = ["org.vinegarhq.Sober"];
    playerctld.enable = true;
  };
}
