{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    ghostty
    git
    bat
    eza
    helix
    gh
    starship
    yazi
    zellij
    fastfetch
    ripgrep
    tealdeer
  ];
}
