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
  } @ inputs: {
    nixosConfigurations.silly-willy = nixpkgs.lib.nixosSystem {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      specialArgs = {inherit inputs;};
      modules = [./system/configuration.nix];
    };

    homeConfigurations = {
      stellaratica = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = [./home];
        extraSpecialArgs = {inherit inputs;};
      };
    };
  };
}
