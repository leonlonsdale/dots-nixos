{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    ghostty
    bat
    eza
    gh
    starship
    yazi
    zellij
    fastfetch
    ripgrep
    tealdeer
  ];
}
