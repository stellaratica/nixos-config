{inputs, pkgs, ...}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  
  users.users.stellaratica = {
    isNormalUser = true;
    initialHashedPassword = "$6$ucT/ZNWKI7Y4tQuJ$nzMl12scpx9pmKqZmeHJUVGx98PlGfz4aDMCKcNCkLi2HBZlrtoWvqisMkoUGWJTCgaI26hSVeAyRhkov4/CX0";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  users.users.root.initialHashedPassword = "$6$wskptZ5YQeXsCOE8$Rs/I5K5eR4fEHFd02B5uMIQtspEiwUKr5rILjmJso7y9vk1czbc4iTVzCyZ/IlMpyudDae.UkpQqNx0xx.9Hu0";

  # home-manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = {inherit inputs;};

  home-manager.users.stellaratica = import ../../home;
}
