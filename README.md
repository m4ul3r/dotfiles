# dotfiles

Stow-managed dotfiles for XPS running omarchy (Hyprland).

## Usage

```bash
# Install all packages (create symlinks in ~)
make install

# Uninstall all packages (remove symlinks)
make uninstall

# Reinstall (prune stale + restow)
make reinstall

# First-time setup (adopt existing files as symlinks)
make adopt

# Dry-run check
make check

# List packages
make list
```

## Packages

| Package | What it manages |
|---------|----------------|
| zsh | `~/.zshrc`, `~/.zshenv` |
| bash | `~/.bashrc`, `~/.bash_profile`, `~/.profile` |
| git | `~/.config/git/config` |
| hypr | `~/.config/hypr/` (Hyprland) |
| waybar | `~/.config/waybar/` |
| walker | `~/.config/walker/` |
| omarchy | `~/.config/omarchy/` (branding, extensions, hooks, themed) |
| alacritty | `~/.config/alacritty/` |
| kitty | `~/.config/kitty/` |
| ghostty | `~/.config/ghostty/` |
| nvim | `~/.config/nvim/` (LazyVim) |
| starship | `~/.config/starship.toml` |
| misc | `~/.gdbinit`, `~/.XCompose` |

## Not tracked

- `~/.config/omarchy/current/` - theme-managed, regenerated on theme switch
- `~/.config/mako/` - symlink managed by omarchy
- `~/.config/nvim/lazy-lock.json` - auto-generated plugin lock
