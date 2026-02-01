{ lib, ... }:
let
  scanPaths = dir:
    lib.concatLists (lib.mapAttrsToList (path: type:
      let 
        abspath = "${toString dir}/${path}";
      in
      if type == "directory" then 
        scanPaths abspath 
      else if (lib.hasSuffix ".nix" path && path != "default.nix") then 
        [ abspath ] 
      else 
        []
    ) (builtins.readDir dir));
in
{
  imports = scanPaths ./.;
    # ++ importDir ./core
    # ++ importDir ./hardware
    # ++ importDir ./shell
    # ++ importDir ./desktops
    # ++ importDir ./appearance
    # ++ importDir ./browsers
    # ++ importDir ./dev;
}
