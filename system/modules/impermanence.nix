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
        "IdeaProjects"
        "Downloads"
        "Pictures"
        "src"
        "Videos"
        ".cargo"
        ".config/dolphin-emu"
        ".config/nvim"
        ".config/obs-studio"
        ".config/Ryujinx"
        ".config/spotify"
        ".config/vesktop"
        ".config/VintagestoryData"
        ".dotfiles"
        ".gnupg"
        ".librewolf"
        ".local/share/dolphin-emu"
        ".local/share/keyrings"
        ".local/share/nvim"
        ".local/share/parallel-launcher"
        ".local/share/PrismLauncher"
        ".local/share/Steam"
        ".local/state/nvim"
        ".rustup"
        ".ssh"
        ".var/app/org.vinegarhq.Sober"
      ];
      files = [
        ".p10k.zsh"
        "Passwords.kdbx"
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
