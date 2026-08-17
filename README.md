# dotfiles

Stow-managed dotfiles for XPS running omarchy (Hyprland).

## Structure

```
home/    -> per-app stow packages, target: ~
config/  -> single stow package, target: ~/.config
```

## Usage

```bash
just install     # create symlinks
just uninstall   # remove symlinks
just reinstall   # prune stale + restow
just adopt       # first-time setup (adopt existing files)
just check       # dry-run
just list        # list packages
```

## What's tracked

**home/** (per-app packages symlinked into `~`)
- `zsh/` - `.zshrc`, `.zshenv`
- `bash/` - `.bashrc`, `.bash_profile`, `.profile`
- `misc/` - `.gdbinit`, `.XCompose`

**config/** (single package symlinked into `~/.config/`)
- `git/`, `hypr/`, `waybar/`, `walker/`, `omarchy/`
- `alacritty/`, `kitty/`, `ghostty/`
- `nvim/`, `tmux/`

## Not tracked

- `~/.config/omarchy/current/` - theme-managed, regenerated on theme switch
- `~/.config/mako/` - symlink managed by omarchy
- `~/.config/nvim/lazy-lock.json` - auto-generated plugin lock

## Dependencies

Installed outside this repo; the hypr config expects them but degrades to
no-ops (pcall guards) when they're missing.

- [hyprland-scroll-overview](https://github.com/yayuuu/hyprland-scroll-overview) -
  niri-style workspace overview (`SUPER + W`, 3-finger vertical swipe).
  Managed by hyprpm (state in `/var/cache/hyprpm/$USER`, invisible to config greps):

  ```bash
  hyprpm add https://github.com/yayuuu/hyprland-scroll-overview.git
  hyprpm enable scrolloverview
  hyprpm reload
  ```

  ABI-sensitive: rerun `hyprpm update` after Hyprland updates to rebuild.
