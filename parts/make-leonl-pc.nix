{
  self,
  inputs,
  withSystem,
  ...
}:
let
  username = "leonl";
  hostname = "leonl-pc";
  stateVersion = "25.11";
  gitName = "Leon Lonsdale";
  gitEmail = "coding@leonlonsdale.dev";

  systemCore =
    { pkgs, ... }:
    {
      nixpkgs.pkgs = pkgs;
      system.stateVersion = stateVersion;
      networking.hostName = hostname;
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      users.users.${username} = {
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        shell = pkgs.zsh;
        home = "/home/${username}";
      };
    };

  homeManagerConfig =
    { pkgs, ... }:
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit
            inputs
            self
            username
            pkgs
            gitName
            gitEmail
            ;
        };
        backupFileExtension = "backup";
        overwriteBackup = true;

        users.${username} = {
          home.username = username;
          home.homeDirectory = "/home/${username}";
          home.stateVersion = stateVersion;
        };
      };
    };
in
{
  flake.nixosConfigurations.${hostname} = withSystem "x86_64-linux" (
    { pkgs, ... }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          self
          inputs
          pkgs
          hostname
          username
          stateVersion
          gitName
          gitEmail
          ;
      };

      modules = [
        inputs.home-manager.nixosModules.home-manager
        systemCore
        homeManagerConfig
        (self + "/hosts/${hostname}.nix")
      ];
    }
  );
}
