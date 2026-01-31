{ ... }:
let
  leonl = users.users.leonl;
in
{
  leonl.isNormalUser = true;
  leonl.description = "Leon Lonsdale";
  leonl.extraGroups = [ "networkmanager" "wheel" ];
  leonl.packages = [];
}
