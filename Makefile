STOW_DIR := $(shell pwd)
TARGET   := $(HOME)
PACKAGES := zsh bash git hypr waybar walker omarchy alacritty kitty ghostty nvim tmux misc
STOW_FLAGS := --no-folding -t $(TARGET)

.PHONY: install uninstall reinstall adopt check list

install:
	@for pkg in $(PACKAGES); do \
		echo "Stowing $$pkg..."; \
		stow $(STOW_FLAGS) $$pkg; \
	done

uninstall:
	@for pkg in $(PACKAGES); do \
		echo "Unstowing $$pkg..."; \
		stow -D $(STOW_FLAGS) $$pkg; \
	done

reinstall:
	@for pkg in $(PACKAGES); do \
		echo "Restowing $$pkg..."; \
		stow -R $(STOW_FLAGS) $$pkg; \
	done

adopt:
	@for pkg in $(PACKAGES); do \
		echo "Adopting $$pkg..."; \
		stow --adopt $(STOW_FLAGS) $$pkg; \
	done

check:
	@for pkg in $(PACKAGES); do \
		stow -n $(STOW_FLAGS) $$pkg 2>&1 || true; \
	done

list:
	@echo "Available packages: $(PACKAGES)"
