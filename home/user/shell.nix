{ lib, pkgs, ... }:
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
        let carapace_completer = {|spans: list<string>|
          CARAPACE_LENIENT=1 carapace $spans.0 nushell ...$spans | from json
          | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
        }
        $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

        let fish_completer = {|spans|
          ${lib.getExe pkgs.fish} --command $'complete "--do-complete=($spans | str join " ")"'
          | $"value(char tab)description(char newline)" + $in
          | from tsv --flexible --no-infer
        }

        let multiple_completers = {|spans|
          let expanded_alias = scope aliases
            | where name == $spans.0
            | get -o 0.expansion

            let spans = if $expanded_alias != null {
              $spans
              | skip 1
              | prepend ($expanded_alias | split row ' ' | take 1)
            } else {
              $spans
            }
          ## alias fixer end

          match $spans.0 {
            nu => $fish_completer
            git => $fish_completer
            _ => $carapace_completer
          } | do $in $spans
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
              completer: $multiple_completers
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
