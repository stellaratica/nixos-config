{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.impermanence.nixosModules.impermanence];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/cups"
      "/var/lib/systemd/coredump"
      "/var/lib/sbctl"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.stellaratica = {
      directories = [
        "cs-11"
        "Downloads"
        "Pictures"
        "src"
        ".cargo"
        ".config/nvim"
        ".config/Ryujinx"
        ".config/vesktop"
        ".dotfiles"
        ".librewolf"
        ".local/share/direnv"
        ".local/share/nvim"
        ".local/share/parallel-launcher"
        ".local/share/PrismLauncher"
        ".local/share/Steam"
        ".local/state/nvim"
        ".rustup"
        { directory = ".ssh"; mode = "0700"; }
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".local/share/keyrings"; mode = "0700"; }
      ];
      files = [
        ".p10k.zsh"
      ];
    };
  };

  boot.initrd.postResumeCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';
}
