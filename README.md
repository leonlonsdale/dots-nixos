# NixOS Configuration

## Prelude

This repository acts as both my NixOS configuration repository and a log of my learning.

I made the decision to leave Windows behind and move to Linux at the end of January 2025 after becoming tired of Windows using so much memory and force feeding AI down my throat. I don't mind using AI when I need to, but I do not want it having access to my entire system. In fact, I code using Helix Editor specifically because it does not support AI.

I spent a day using CachyOS, which is great, but when everything is already set up for you, it removes the need to learn some things, and I wanted to learn. I read about the Nix declarative approach and it made a lot of sense to me, and so NixOS became my distro of choice.

## Credits

The following folks have donated time to answer my questions. A big thanks to them:

- [A1RMAX](https://youtube.com/@a1rm4x?si=Vj4Rq-0magk46NbB) - great youtube videos. These vids convinced me to try NixOS.

- [vimjoyer](https://www.youtube.com/@vimjoyer) - videos
  Great videos on all things nix.

- [mightyiam](https://github.com/mightyiam) - Author of the Full Time Nix podcast, initiator of the NixOS dendritic pattern.

- [emzy](https://github.com/emzywastaken/dotfiles) - configuration.
  Their configuration, although advanced, is very cleanly written and understandable. I've saved myself a lot of typing by reading this config and getting some ideas.

- LuckShiba - from the [DMS/Niri discord](https://discord.gg/CcHgGnfGXf).
  Has answered a lot of questions where I'm sure most people would tell me to get lost.

- [Yui Tayuun](https://codeberg.org/yuitayuun) for the help getting Icons working.

- [viena](https://github.com/devnchill) - from the [unofficial nixos discord](https://discord.gg/2MJZpTM6) for pointing me in the right direction for the cursor fix.


## NixOS Configuration

### Known Issues

- DMS cycles through my wallpapers. Every time the wallpaper changes, I get a "Reloaded the configuration" notification.

### Resolved Issues

#### Dank Material Shell settings are 'read only'.

When setting up DMS via flake via home-manager, using any of the `settings` or `system` setting options causes  the configuration to become read only. Removing these settings fixed this issue.

#### Dank Material Shell is unable to overwride Niri settings within the Niri Override area of the settings menu.

Unless `programs.niri.settings` is part of the configuration, the settings file is not created. The DMS overrides do not create this for you and so this must be included.

#### The PC wakes from suspend with a black screen.

Changing `hardware.nvidia.powerManagement.enable = true;` as suggested in [the official wiki](https://wiki.nixos.org/wiki/NVIDIA#:~:text=hardware%2Envidia%2EpowerManagement%2Eenable%20%3D%20true) appears to have resolved the issue.

#### The system sometimes boots into TTY and not into the sddm greeter

I installed DMS Greeter, and so far the issue has not happened again. I still do not know what was causing the original issue.

#### DMS App launcher menu does not display icons.

This was a rookie error - I had to install an icon theme, such as:

```nix
pkgs.adwaita-icon-theme
```

#### Mouse cursor is not themed, and is pretty huge.

As above, I had to install a cursor theme.


#### I do not know how to install my personal wallpapers from my repo

After speaking with vimjoyer, he recommended `hjem` for this job. This worked great.

```nix
# flake.nix

# inputs
hjem.url = "github:feel-co/hjem"
hjem.inputs.nixpkgs.follows = "nixpkgs";
wallpapers.url = "github:<user>/<repo>"
wallpapers.flake = false;

# outputs
  # nixosConfigurations...
  modules = [
    # ...
    hjem.nixosModules.default
  ];

# modules/ui/wallpaper.nix (where I wrote it)

{ inputs, ... }:
{
  hjem.users."yourusername" = {
    enable = true;
    # store in /home/users/<username>/wallpapers
    files."wallpapers".source = inputs.wallpapers;
  };
}
```

NOTE: To get this to work nicely with home manager, I had to add the following line. Without it, the two of them conflicted and home-manager failed to load.

```nix
hjem.users.${username}.systemd.enable = false;
```

### Todo

#### Common

- [x] Install NixOS
- [x] Modularise the default config
- [x] Switch to flakes
- [x] Set up nvidia drivers
- [ ] How to install [OpenLinkHub](https://github.com/jurkovic-nikola/OpenLinkHub) - I have a lot of Corsair iCUE Link hardware, on all PCs.
- [ ] How to add [Arkenfox Firefox Tweaks](https://github.com/arkenfox/user.js)

#### Coder Profile

##### Terminal, Shell & CLI

- [x] Implement Shells
  - [x] Zsh
    - [x] zsh auto suggestions
    - [x] zsh syntax highlighting
  - [x] Fish
  - [x] Integrate cli tools based on active shell
- [x] Install favorite CLI tools
  - [x] starship
    - [x] Configure with personal prompt design
  - [x] bat
  - [x] btop
  - [x] eza
  - [x] tealdeer
  - [x] fd
  - [x] jq
  - [x] zoxide
  - [x] zellij
  - [x] ripgrep
  - [x] lazygit
  - [x] yazi
  - [x] fzf
  - [x] fastfetch
  - [x] github cli
  - [x] git
- [x] Imeplement Terminals
  - [x] Ghostty
  - [x] Kitty
  - [x] Foot

##### Dev stuff

- [x] Install and configure Helix Editor from master
  - [ ] Make Helix configs apply to both User and Root
- [x] Install LSPs, Formatters, and Linters

##### Apperance

- [x] Install Niri
- [x] Install DankMaterialShell
- [x] Install DankMaterialShell Greeter
- [x] Install my personal wallpapers
- [x] Install favourite monospace nerd fonts

#### Todo (Gamer profile)

- [ ] Install and configure Hyprland
- [x] Install Steam

### Coding & Structure

- [ ] Get a full understanding of nix code structure
- [ ] Get a full understanding of flakes
- [ ] Get a full understanding of home-manager
- [ ] Get a full understanding of hjem
- [ ] Get a full understanding of flake parts
- [ ] Implement dendritic structure


## Dendritic Pattern

I have begun figuring this out on my spare PC. While I do have it working on a basic configuration, I need to spend more time reading up about it and how I can mirror the granular control I have within my current configuration.

### Resources

#### Literature

- [Mightyiam - dendritic](https://github.com/mightyiam/dendritic)
- [Doc-Steve](https://github.com/Doc-Steve/dendritic-design-with-flake-parts/wiki/Dendritic_Aspects)

#### Tools

- [flake-parts](https://github.com/hercules-ci/flake-parts)
- [import-tree](https://github.com/vic/import-tree)
- [flake-file](https://github.com/vic/flake-file)
