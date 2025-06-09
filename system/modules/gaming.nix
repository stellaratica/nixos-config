{inputs, ...}: {
  imports = with inputs.nix-gaming.nixosModules; [
    pipewireLowLatency
    platformOptimizations
  ];

  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  services.pipewire.lowLatency.enable = true;
  programs.steam.platformOptimizations.enable = true;
}
