{inputs, ...}: {
  imports = [inputs.impermanence.homeManagerModules.impermanence];

  home.persistence."/persist/home/stellaratica" = {
    directories = [
      "Downloads"
      "Pictures"
      "src"
      ".cargo"
      ".config/nvim"
      ".config/Ryujinx"
      ".config/vesktop"
      ".dotfiles"
      ".gnupg"
      ".librewolf"
      ".local/share/keyrings"
      ".local/share/nvim"
      ".local/share/parallel-launcher"
      ".local/share/PrismLauncher"
      ".local/state/nvim"
      ".rustup"
      ".ssh"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    files = [
      ".p10k.zsh"
      "Passwords.kdbx"
    ];
    allowOther = true;
  };
}
