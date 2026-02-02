{
  self,
  inputs,
  withSystem,
  ...
}:

let
  mkConfig =
    hostname: stateVersion: username: gitName: gitEmail:
    withSystem "x86_64-linux" (
      { pkgs, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit
            self
            inputs
            hostname
            username
            stateVersion
            gitName
            gitEmail
            ;
        };
        modules = [
          { nixpkgs.pkgs = pkgs; }
          inputs.catppuccin.nixosModules.catppuccin
          inputs.hjem.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          (self + "/hosts/${hostname}")
        ];
      }
    );
in
{
  flake.nixosConfigurations = {

    # mkConfig "hostname" "stateVersion" "username" "gitName" "gitEmail"
    leonl-pc = mkConfig "leonl-pc" "25.11" "leonl" "Leon Lonsdale" "coding@leonlonsdale.dev";
  };
}
