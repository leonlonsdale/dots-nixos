{ lib, ... }:
let
  importDir = dir: 
    let 
      contents = builtins.readDir dir;
    in
    lib.mapAttrsToList (name: type: "${toString dir}/${name}") 
      (lib.filterAttrs (name: type: 
        (type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix") || 
        (type == "directory")
      ) contents);
in
{
  imports = []
    ++ importDir ./cli;
}
