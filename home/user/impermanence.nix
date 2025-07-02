{inputs, ...}: {
  imports = [inputs.impermanence.homeManagerModules.impermanence];

  home.persistence."/persist/home/stellaratica" = {
    directories = [
      "Downloads"
      "Pictures"
      "src"
      ".config/nvim"
      ".dotfiles"
      ".gnupg"
      ".librewolf"
      ".local/share/keyrings"
      ".local/share/nvim"
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
