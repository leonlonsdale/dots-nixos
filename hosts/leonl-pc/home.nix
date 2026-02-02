{
  inputs,
  self,
  pkgs,
  username,
  stateVersion,
  gitName,
  gitEmail,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit
        inputs
        self
        username
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
}
