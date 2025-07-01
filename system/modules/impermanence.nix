{inputs, ...}: {
  imports = [inputs.impermanence.nixosModules.impermanence];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/cups"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.stellaratica = {
      directories = [
        "Downloads"
        "Pictures"
        "src"
        ".dotfiles"
        ".librewolf"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
      ];
      files = [
        ".p10k.zsh"
      ];
    };
  };
}
