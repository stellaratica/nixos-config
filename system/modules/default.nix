{lib, ...}: {
  imports = lib.lists.remove ./default.nix (lib.filesystem.listFilesRecursive ./.);
}
