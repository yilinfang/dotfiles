MISE_BIN := ${HOME}/.local/bin/mise
MISE_DEFAULT_CONFIG_PATH := ${HOME}/.config/mise/config.toml
MISE_INSTALL_CMD := curl https://mise.run | sh
CHEZMOI := ${MISE_BIN} exec chezmoi age -- chezmoi
CHEZMOI_DOTFILES_DIR := ${HOME}/.chezmoi/dotfiles

.PHONY: install pde_install clean ensure_mise

ensure_mise:
	@if [ ! -f "${MISE_BIN}" ]; then \
		echo "Installing Mise..."; \
		${MISE_INSTALL_CMD}; \
	else \
		echo "Mise is already installed."; \
		${MISE_BIN} self-update; \
	fi
	@if [ ! -f "${MISE_DEFAULT_CONFIG_PATH}" ]; then \
		echo "Creating default Mise config..."; \
		mkdir -p "$$(dirname "${MISE_DEFAULT_CONFIG_PATH}")"; \
		touch "${MISE_DEFAULT_CONFIG_PATH}"; \
	fi

install: ensure_mise
	@echo "Applying dotfiles with Chezmoi..."
	${CHEZMOI} init --apply -S ${CHEZMOI_DOTFILES_DIR}
	${MISE_BIN} install
	${MISE_BIN} upgrade

pde_install: ensure_mise
	@echo "Applying PDE-specific dotfiles with Chezmoi..."
	IS_PDE=true ${CHEZMOI} init --apply -S ${CHEZMOI_DOTFILES_DIR}
	${MISE_BIN} install
	${MISE_BIN} upgrade
	bash scripts/pde/setup-shell.sh
	bash scripts/pde/setup-git.sh

clean:
	@echo "Removing all dotfiles managed by Chezmoi..."
	${CHEZMOI} managed --path-style=absolute | while read -r f; do \
		echo "Deleting $$f"; \
		rm -rf "$$f"; \
	done
	@echo "Some scripts located in ~/.local/bin may need to be removed manually."
