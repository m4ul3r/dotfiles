HOME_PKGS := zsh bash misc
STOW_FLAGS := --no-folding

.PHONY: install uninstall reinstall adopt check list

install:
	@for pkg in $(HOME_PKGS); do \
		echo "Stowing $$pkg..."; \
		stow -d home $(STOW_FLAGS) -t $(HOME) $$pkg; \
	done
	@echo "Stowing config..."
	@stow $(STOW_FLAGS) -t $(HOME)/.config config

uninstall:
	@for pkg in $(HOME_PKGS); do \
		echo "Unstowing $$pkg..."; \
		stow -D -d home $(STOW_FLAGS) -t $(HOME) $$pkg; \
	done
	@echo "Unstowing config..."
	@stow -D $(STOW_FLAGS) -t $(HOME)/.config config

reinstall:
	@for pkg in $(HOME_PKGS); do \
		echo "Restowing $$pkg..."; \
		stow -R -d home $(STOW_FLAGS) -t $(HOME) $$pkg; \
	done
	@echo "Restowing config..."
	@stow -R $(STOW_FLAGS) -t $(HOME)/.config config

adopt:
	@for pkg in $(HOME_PKGS); do \
		echo "Adopting $$pkg..."; \
		stow --adopt -d home $(STOW_FLAGS) -t $(HOME) $$pkg; \
	done
	@echo "Adopting config..."
	@stow --adopt $(STOW_FLAGS) -t $(HOME)/.config config

check:
	@for pkg in $(HOME_PKGS); do \
		stow -n -d home $(STOW_FLAGS) -t $(HOME) $$pkg 2>&1 || true; \
	done
	@stow -n $(STOW_FLAGS) -t $(HOME)/.config config 2>&1 || true

list:
	@echo "Home packages: $(HOME_PKGS)"
	@echo "Config: single package (config/)"
