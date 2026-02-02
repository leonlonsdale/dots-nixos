{ lib, username, ... }:
let
  scanPaths =
    dir:
    lib.concatLists (
      lib.mapAttrsToList (
        path: type:
        let
          abspath = "${toString dir}/${path}";
        in
        if type == "directory" then
          scanPaths abspath
        else if (lib.hasSuffix ".nix" path && path != "default.nix") then
          [ abspath ]
        else
          [ ]
      ) (builtins.readDir dir)
    );
in
{
  hjem.users.${username}.systemd.enable = false;
  imports = scanPaths ./.;
}
