{
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
{
  # ============================================================================
  # SYSTEM IDENTITY
  # ============================================================================
  # Variables pulled from specialArgs in parts/nixos.nix
  networking.hostName = hostname;
  system.stateVersion = stateVersion;

  # ============================================================================
  # USER ACCOUNT (NixOS Level)
  # ============================================================================
  # Grouped under the dynamic ${username} key to avoid "already defined" errors.
  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;

    # Standard groups. Use lib.mkForce [ ] in host files to override or clear these.
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
  };

  # ============================================================================
  # HOME MANAGER GLOBAL CONFIGURATION
  # ============================================================================
  # To revert back to a per-host config, put this into /hosts/hostname/home.nix
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.overwriteBackup = true;

  # Pass flake inputs and variables down to Home Manager modules
  home-manager.extraSpecialArgs = {
    inherit
      inputs
      self
      username
      gitName
      gitEmail
      ;
  };

  # Standardise user home settings across all hosts
  # Grouped to prevent "dynamic attribute already defined" collisions.
  home-manager.users.${username} = {
    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = stateVersion;
  };

  # ============================================================================
  # NIX PACKAGE MANAGER SETTINGS
  # ============================================================================
  # Deduplicates store files to save space
  nix.settings.auto-optimise-store = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # ============================================================================
  # MAINTENANCE & GARBAGE COLLECTION
  # ============================================================================
  # Automatically removes unreferenced packages weekly
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";

  # Keeps the last week of generations for safety rollbacks
  nix.gc.options = "--delete-older-than 7d";

  # Deep optimisation scan to recover disk space
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];

  # ============================================================================
  # FLAKE & REGISTRY SYNC
  # ============================================================================
  # Ensures 'nix run/shell' matches flake.lock versions
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  # Syncs legacy NIX_PATH to prevent double downloads of nixpkgs
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  # ============================================================================
  # DISK SPACE OPTIMISATION (DOCUMENTATION)
  # ============================================================================
  # Disable heavy HTML/PDF docs; keep man-pages for the terminal
  documentation.enable = true;
  documentation.doc.enable = false;
  documentation.man.enable = true;
  documentation.nixos.enable = false;
}
