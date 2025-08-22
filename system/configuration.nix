{inputs, ...}: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-raphael-igpu
    ./hardware-configuration.nix
    ./modules
  ];

  system.stateVersion = "24.11";
}
