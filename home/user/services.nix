{ inputs, ... }:
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];
  services = {
    clipse.enable = true;
    flatpak.packages = [ "org.vinegarhq.Sober" ];
    playerctld.enable = true;
  };
}
