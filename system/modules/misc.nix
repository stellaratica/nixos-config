{pkgs, ...}: {
  environment = {
    pathsToLink = ["/share/base-completion" "/share/zsh"]; # for command completion
    shells = with pkgs; [
      bashInteractive
      zsh
    ];
  };

  users.defaultUserShell = pkgs.bashInteractive;

  security.sudo.keepTerminfo = true;

  services = {
    flatpak.enable = true; # for certain otherwise unavailable packages
    gvfs.enable = true; # for stuff like trash
    kmscon = {
      enable = true;
      extraConfig = ''
        session-control

        palette=custom

        palette-black=69, 71, 90
        palette-red=243, 139, 168
        palette-green=166, 227, 161
        palette-yellow=249, 226, 175
        palette-blue=137, 180, 250
        palette-magenta=245, 194, 231
        palette-cyan=148, 226, 213
        palette-light-grey=166, 173, 200
        palette-dark-grey=88, 91, 112
        palette-light-red=245, 130, 160
        palette-light-green=149, 224, 150
        palette-light-yellow=246, 222, 157
        palette-light-blue=131, 174, 254
        palette-light-magenta=248, 185, 230
        palette-light-cyan=123, 224, 210
        palette-white=186, 194, 222
        palette-foreground=205, 214, 244
        palette-background=30, 30, 46
      '';
      fonts = [
        {
          name = "Hack Nerd Font Mono";
          package = pkgs.nerd-fonts.hack;
        }
      ];
      hwRender = true;
    };

    udev.extraRules = ''
      ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", ENV{DISPLAY}=":0", RUN+="${pkgs.su}/bin/su stellaratica -c '$$HOME/.config/waybar/scripts/battery-state.sh discharging'"
      ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", ENV{DISPLAY}=":0", RUN+="${pkgs.su}/bin/su stellaratica -c '$$HOME/.config/waybar/scripts/battery-state.sh charging'"
    '';
  };

  programs = {
    zsh.enable = true;
    ssh.startAgent = true;
    dconf.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
}
