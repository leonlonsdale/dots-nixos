{ config, inputs, hostname, username, pkgs, self, stateVersion,  ... }:
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    (self + "/modules")
  ];

  system.stateVersion = stateVersion;
  networking.hostName = hostname;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    home = "/home/${username}";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs self username; };
    backupFileExtension = "backup";
    overwriteBackup = true;

    users.${username} = {
      home.username = username;
      home.homeDirectory = "/home/${username}";
      home.stateVersion = stateVersion;
    };
  };

  modules = {
    shell = {
      zsh.enable = true;
    }; 

    dev = {
      cli = {
        git.enable = true;
      };
    };
  };
}
