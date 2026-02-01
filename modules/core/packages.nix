{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    ghostty
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
