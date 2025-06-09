{inputs, ...}: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
    ./hardware-configuration.nix
    ./modules
  ];

  system.stateVersion = "24.11";
}
