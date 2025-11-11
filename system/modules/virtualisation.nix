{...}: {
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = ["stellaratica"];

  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
}
