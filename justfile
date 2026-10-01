home_pkgs := "zsh bash misc claude bin"
stow_flags := "--no-folding --ignore='[.]bak([.].*)?$'"

# symlink everything
install:
    #!/usr/bin/env bash
    set -euo pipefail
    for pkg in {{home_pkgs}}; do
        echo "Stowing $pkg..."
        stow -d home {{stow_flags}} -t "$HOME" "$pkg"
    done
    echo "Stowing config..."
    stow {{stow_flags}} -t "$HOME/.config" config

# remove symlinks
uninstall:
    #!/usr/bin/env bash
    set -euo pipefail
    for pkg in {{home_pkgs}}; do
        echo "Unstowing $pkg..."
        stow -D -d home {{stow_flags}} -t "$HOME" "$pkg"
    done
    echo "Unstowing config..."
    stow -D {{stow_flags}} -t "$HOME/.config" config

# prune stale + restow
reinstall:
    #!/usr/bin/env bash
    set -euo pipefail
    for pkg in {{home_pkgs}}; do
        echo "Restowing $pkg..."
        stow -R -d home {{stow_flags}} -t "$HOME" "$pkg"
    done
    echo "Restowing config..."
    stow -R {{stow_flags}} -t "$HOME/.config" config

# first-time: adopt existing files into the repo
adopt:
    #!/usr/bin/env bash
    set -euo pipefail
    for pkg in {{home_pkgs}}; do
        echo "Adopting $pkg..."
        stow --adopt -d home {{stow_flags}} -t "$HOME" "$pkg"
    done
    echo "Adopting config..."
    stow --adopt {{stow_flags}} -t "$HOME/.config" config

# dry-run all packages; return failure if any package conflicts
check:
    #!/usr/bin/env bash
    set -uo pipefail
    failed=0
    for pkg in {{home_pkgs}}; do
        echo "Checking $pkg..."
        stow -n -d home {{stow_flags}} -t "$HOME" "$pkg" 2>&1 || failed=1
    done
    echo "Checking config..."
    stow -n {{stow_flags}} -t "$HOME/.config" config 2>&1 || failed=1
    exit "$failed"

# list packages
list:
    @echo "Home packages: {{home_pkgs}}"
    @echo "Config: single package (config/)"
