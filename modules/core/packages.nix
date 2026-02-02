{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
    curl
    vim
    gh
  ];
}
