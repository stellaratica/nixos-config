{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      cat = "bat";
      fullclean = ''
        nix-collect-garbage --delete-old
        sudo nix-collect-garbage -d
        sudo /run/current-system/bin/switch-to-configuration boot
      '';
      l = "eza";
      ll = "eza -la";
      la = "eza -a";
      nixswitch = "sudo nixos-rebuild switch";
      homeswitch = "home-manager switch --flake ~/.dotfiles";
      fullswitch = "nixswitch && homeswitch";
    };
    initContent = ''
      source ~/.p10k.zsh
      fastfetch
    '';
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };
}
