# nixos-config

## About

This is my NixOS config.

I started on CachyOS after switching from Windows in January 2026, but was tempted to give Nix a try after watching videos on youtue by [vimjoyer](https://www.youtube.com/@vimjoyer).

The config is a bit of a hobby project, learning nix and how to configure declaratively. Who knows, it may become my main distro if it goes well enough.

Why? I have a habit of reinstalling my OS. Often for no reason. I have to setup my environment from scratch each time. It's not so bad with my dotfiles available to pull, but I still have to install all my packages through pacman, brew, yay, and npm. My dotfiles don't actually change all that much either. The idea that I can just have a nix configuration that I pull and run, and everything is done for me, is very attractive.

## Known Issues

- [x] Dank Material Shell settings read only

It would appear that using any `settings.xyz` or `system.xyz` options within the set up creates a read-only file. Removing these allows DMS to manage a file with live updates via the settings menus.

- [x] Dank Material Shell is unable to override Niri in the Niri Override settings.

It appears that `programs.niri.settings` must be called within the dms home-manager settings or the file is not created. Without the file, DMS cannot write to it.

- [x] Improper wake up from suspend - black screen on awake.

Tried adding, the below, as recommended by [this video](https://www.youtube.com/watch?v=yALrQP3tW9w&themeRefresh=1):

```nix
boot.kernelParams = [
  "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
];
```
However, this had the opposite effect - the system would no longer suspend.

Changing `hardware.nvidia.powerManagement.enable = true;` as suggested in [the official wiki](https://wiki.nixos.org/wiki/NVIDIA#:~:text=hardware%2Envidia%2EpowerManagement%2Eenable%20%3D%20true) appears to have resolved the issue.

- [x] System sometimes boots to tty and sometimes to Plymouth.

Fixed this without figuring out the issue - I just installed DMS Greeter, and so far the issue has not happened again.

- [x] App launcher menu does not display icons.

This one turned out rather simple - simply installing an icon theme.

Adding:

```nix
pkgs.adwaita-icon-theme
```

for example. Module created under /modules/appearance/ui/icons.nix

- [x] Mouse cursor is not themed, and is pretty huge.

This one also turned out to be rather simple. Like the application icons, it just required installation of a cursor theme.

I created a module or cursor themes under /modules/appearance/ui/cursors.nix

## Things to learn

- [x] Home Manager. It's included in my config but I don't actually know how it works or how to use it properly. I'm kinda just getting lucky with it.

- [x] flake-parts. I'm a big big fan of doing things in a modular way (you may notice from my config setup). Afte watching videos by [vimjoyer](https://www.youtube.com/@vimjoyer) about [flake-parts](https://www.youtube.com/watch?v=kvprcW6QMIE) and the [dendritic approach](https://www.youtube.com/watch?v=-TRbzkw6Hjs), I want to learn how to do this and implement it.

- [x] How to install fonts

- [x] How to install my wallpapers repo.

I did this with [hjem](https://github.com/feel-co/hjem).


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

- [ ] How to install [OpenLinkHub](https://github.com/jurkovic-nikola/OpenLinkHub) - I have a lot of Corsair iCUE Link hardware.

- [ ] How to add [Arkenfox Firefox Tweaks](https://github.com/arkenfox/user.js)

## Todo

### Common

- [x] Install NixOS
- [x] Modularise the default config
- [x] Switch to flakes
- [x] Set up nvidia drivers

### Coder Profile

#### Terminal, Shell & CLI

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

#### Dev stuff

- [x] Install and configure Helix Editor from master
  - [ ] Make Helix configs apply to both User and Root
- [x] Install LSPs, Formatters, and Linters

#### Apperance

- [x] Install Niri
- [x] Install DankMaterialShell
- [x] Install DankMaterialShell Greeter
- [x] Install my personal wallpapers
- [x] Install favourite monospace nerd fonts

### Todo (Gamer profile)

- [ ] Install and configure Hyprland
- [x] Install Steam

## Coding & Structure

- [ ] Get a full understanding of nix code structure
- [ ] Get a full understanding of flakes
- [ ] Get a full understanding of home-manager
- [ ] Get a full understanding of hjem
- [ ] Get a full understanding of flake parts
- [ ] Implement dendritic structure

## Inspirations & Credits

- [vimjoyer](https://www.youtube.com/@vimjoyer) - videos
  Great videos on all things nix.

- [emzy](https://github.com/emzywastaken/dotfiles) - configuration.
  Their configuration, although advanced, is very cleanly written and understandable. I've saved myself a lot of typing by reading this config and getting some ideas.

- LuckShiba - from the [DMS/Niri discord](https://discord.gg/CcHgGnfGXf).
  Has answered a lot of questions where I'm sure most people would tell me to get lost.

- [Yui Tayuun](https://codeberg.org/yuitayuun) for the help getting Icons working.

- [viena](https://github.com/devnchill) - from the [unofficial nixos discord](https://discord.gg/2MJZpTM6) for pointing me in the right direction for the cursor fix.
