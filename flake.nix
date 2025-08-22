{
  description = "Stella's NixOS configuration for their linux laptop";

  inputs = {
    # official NixOS package source, using unstable by default
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05"; # new stable finally!!!

    # home-manager, for user configuration
    home-manager = {
      url = "github:nix-community/home-manager/master";

      # sync nixpkgs for home-manager with system to prevent inconsistencies
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # pre-made hardware configurations for specific/quirky systems
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    impermanence.url = "github:nix-community/impermanence";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    # various optimizations
    nix-gaming.url = "github:fufexan/nix-gaming";

    # pretty spotify
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.silly-willy = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {inherit inputs;};
      modules = [./system/configuration.nix];
    };

    # Standalone HM
    homeConfigurations = {
      stellaratica = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./home];
        extraSpecialArgs = {inherit inputs;};
      };
    };

    formatter.x86_64-linux = pkgs.alejandra;
  };
}
