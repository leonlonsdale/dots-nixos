{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    bat
    eza
    gh
    yazi
    zellij
    fastfetch
    ripgrep
    tealdeer
  ];
}
