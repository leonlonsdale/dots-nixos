{
  config,
  inputs,
  pkgs,
  hostname,
  stateVersion,
  username,
  self,
  gitName,
  gitEmail,
  ...
}:
let
  # Check if specific shell modules are enabled to determine the system shell
  fishEnabled = config.modules.shell.fish.enable or false;
  zshEnabled = config.modules.shell.zsh.enable or false;

  # Priority logic: Fish takes precedence if enabled, otherwise Zsh,
  # falling back to Zsh if neither (or both) are explicitly set.
  defaultShell =
    if fishEnabled then
      pkgs.fish
    else if zshEnabled then
      pkgs.zsh
    else
      pkgs.zsh;
in
{
  # ============================================================================
  # SYSTEM IDENTITY
  # ============================================================================
  networking.hostName = hostname;
  system.stateVersion = stateVersion;

  # ============================================================================
  # USER ACCOUNT (NixOS Level)
  # ============================================================================
  users.users.${username} = {
    isNormalUser = true;
    shell = defaultShell;

    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
  };

  # ============================================================================
  # HOME MANAGER GLOBAL CONFIGURATION
  # ============================================================================
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.overwriteBackup = true;

  home-manager.extraSpecialArgs = {
    inherit
      inputs
      self
      username
      gitName
      gitEmail
      ;
  };

  home-manager.users.${username} = {
    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = stateVersion;
  };

  # ============================================================================
  # NIX PACKAGE MANAGER SETTINGS
  # ============================================================================
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # ============================================================================
  # MAINTENANCE & GARBAGE COLLECTION
  # ============================================================================
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 7d";

  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];

  # ============================================================================
  # FLAKE & REGISTRY SYNC
  # ============================================================================
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # ============================================================================
  # DISK SPACE OPTIMISATION (DOCUMENTATION)
  # ============================================================================
  documentation.enable = true;
  documentation.doc.enable = false;
  documentation.man.enable = true;
  documentation.nixos.enable = false;
}
