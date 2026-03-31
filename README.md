# dotfiles

Stow-managed dotfiles for XPS running omarchy (Hyprland).

## Structure

```
home/    -> per-app stow packages, target: ~
config/  -> single stow package, target: ~/.config
```

## Usage

```bash
make install     # create symlinks
make uninstall   # remove symlinks
make reinstall   # prune stale + restow
make adopt       # first-time setup (adopt existing files)
make check       # dry-run
make list        # list packages
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
