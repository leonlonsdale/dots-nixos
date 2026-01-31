{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ./nvidia.nix
      ./modules/core/boot.nix
      ./modules/core/networking.nix
      ./modules/core/firewall.nix
      ./modules/core/audio.nix
      ./modules/core/locale.nix
      ./modules/core/packages.nix
      ./modules/profiles/leonl.nix
      ./modules/core/peripherals.nix
      ./modules/desktops/kdeplasma.nix
      ./modules/core/gnugagent.nix
      ./modules/core/openssh.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  programs.firefox.enable = true;
  system.stateVersion = "25.11"; # Did you read the comment?
}
