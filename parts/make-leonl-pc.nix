{ self, inputs, ... }:
let
  username = "leonl";
  hostname = "leonl-pc";
  stateVersion = "25.11";
  gitName = "Leon Lonsdale";
  gitEmail = "coding@leonlonsdale.dev";
in
{
  flake.nixosConfigurations.leonl-pc = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit self inputs hostname username stateVersion gitName gitEmail; };
    modules = [ (self + "/hosts/leonl-pc.nix") ];
  };
}
