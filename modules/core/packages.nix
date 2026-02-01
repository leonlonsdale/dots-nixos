{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    ghostty
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
