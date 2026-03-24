{ pkgs, ... }:
{
  programs = {
    zsh = {
      # enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      localVariables = {
        PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      };
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
        nixswitch = "sudo nixos-rebuild switch --flake ~/.dotfiles";
        nixtest = "sudo nixos-rebuild test --flake ~/.dotfiles";
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
    nushell = {
      enable = true;
      extraConfig = ''
        let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
        }
        $env.config = {
          show_banner: false,
          completions: {
            quick: true
            partial: true
            algorithm: "fuzzy"
            external: {
              enable: true
              max_results: 100
              completer: $carapace_completer
            }
          }
        }
        $env.PATH = ($env.PATH | 
        split row (char esep) |
        prepend /home/myuser/.apps |
        append /usr/bin/env
        )
      '';
      shellAliases = {
        cat = "bat";
        l = "ls";
        ll = "ls -la";
        la = "ls -a";
        nixswitch = "sudo nixos-rebuild switch --flake ~/.dotfiles";
        nixtest = "sudo nixos-rebuild test --flake ~/.dotfiles";
      };
    };
    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[](bold green)";
          error_symbol = "[](bold red)";
        };
      };
    };
  };
}
