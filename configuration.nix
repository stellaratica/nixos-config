# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    # <nixos-hardware/asus/zephyrus/ga401>
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "silly-willy"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.firewall.allowedUDPPorts = [ 5353 ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.stellaratica = {
    isNormalUser = true;
    description = "Stellaratica";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    bluez
    bluez-tools
    wl-clipboard
    zip
    unzip
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # Temporarily messy area

  console.colors = [
    # black
    "45475a"
    "585b70"

    # red
    "f38ba8"
    "f582a0"

    # green
    "a6e3a1"
    "95e096"

    # yellow
    "f9e2af"
    "f6de9d"

    # blue
    "89b4fa"
    "83aefe"

    # magenta
    "f5c2e7"
    "f8b9e6"

    # cyan
    "94e2d5"
    "7be0d2"

    # white
    "a6adc8"
    "bac2de"
  ];

  security.rtkit.enable = true;

  services = {
    asusd.enable = true;
    displayManager.ly.enable = true;
    flatpak.enable = true;
    tlp.enable = true;
    udisks2.enable = true;
    upower.enable = true;

    evremap = {
      enable = true;
      settings = {
        device_name = "Bluetooth Keyboard";
        remap = [
          {
            input = [
              "KEY_HOMEPAGE"
            ];
            output = [
              "KEY_ESC"
            ];
          }
        ];
      };
    };

    kmscon = {
      enable = true;
      hwRender = true;
      fonts = [
        {
          name = "Hack Nerd Font Mono";
          package = pkgs.nerd-fonts.hack;
        }
      ];
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
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    udev = {
      extraRules = ''
        ACTION=="add", SUBSYSTEM=="input", ATTRS{id/vendor}=="04e8", ATTRS{id/product}=="7021", ENV{SYSTEMD_ALIAS}="/dev/dumbkeyboard", SYMLINK+="dumb-keyboard", TAG+="systemd", ENV{SYSTEMD_WANTS}="evremap@dumbkeyboard.service"
      '';
    };
  };

  systemd.services.evremap.enable = lib.mkForce false;

  systemd.services."evremap@" = {
    description = "evremap - keyboard input remapper";
    # wantedBy = [ "multi-user.target" ];
    bindsTo = [ "dev-%i.device" ];
    after = [ "dev-%i.device" ];

    serviceConfig = {
      ExecStart = "${lib.getExe pkgs.evremap} remap ${
        (pkgs.formats.toml { }).generate "evremap.toml" (
          lib.attrsets.filterAttrs (n: v: v != null) config.services.evremap.settings
        )
      }";

      DynamicUser = true;
      User = "evremap";
      SupplementaryGroups = [
        config.users.groups.input.name
        config.users.groups.uinput.name
      ];
      Restart = "on-failure";
      RestartSec = 5;
      TimeoutSec = 20;

      # Hardening
      ProtectClock = true;
      ProtectKernelLogs = true;
      ProtectControlGroups = true;
      ProtectKernelModules = true;
      ProtectHostname = true;
      ProtectKernelTunables = true;
      ProtectProc = "invisible";
      ProtectHome = true;
      ProcSubset = "pid";

      PrivateTmp = true;
      PrivateNetwork = true;
      PrivateUsers = true;

      RestrictRealtime = true;
      RestrictNamespaces = true;
      RestrictAddressFamilies = "none";

      MemoryDenyWriteExecute = true;
      LockPersonality = true;
      IPAddressDeny = "any";
      AmbientCapabilities = "";
      CapabilityBoundingSet = "";
      SystemCallArchitectures = "native";
      SystemCallFilter = [
        "@system-service"
        "~@resources"
        "~@privileged"
      ];
      UMask = "0027";
    };

  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  programs = {
    dconf.enable = true;
    zsh.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    nix-ld = {
      # enable = true;
      libraries = with pkgs; [
        icu
        glibc
      ];
    };

    # Install Steam
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    # Set up PCI bus ids for gpus
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      amdgpuBusId = "PCI:4:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # package = config.boot.kernelPackages.nvidiaPackages.latest;

    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "570.133.07";
      # this is the third one it will complain is wrong
      sha256_64bit = "sha256-LUPmTFgb5e9VTemIixqpADfvbUX1QoTT2dztwI3E3CY=";
      # unused
      sha256_aarch64 = "sha256-2l8N83Spj0MccA8+8R1uqiXBS0Ag4JrLPjrU3TaXHnM=";
      # this is the second one it will complain is wrong
      openSha256 = "sha256-9l8N83Spj0MccA8+8R1uqiXBS0Ag4JrLPjrU3TaXHnM=";
      # this is the first one it will complain is wrong
      settingsSha256 = "sha256-XMk+FvTlGpMquM8aE8kgYK2PIEszUZD2+Zmj2OpYrzU=";
      # unused
      persistencedSha256 = "sha256-4l8N83Spj0MccA8+8R1uqiXBS0Ag4JrLPjrU3TaXHnM=";
    };
  };

  fileSystems."/home/stellaratica/games" = {
    label = "games";
    fsType = "ext4";
    options = [
      "nofail"
      "users"
      "exec"
      "dev"
      "suid"
    ];
  };

}
