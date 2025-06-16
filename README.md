# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Usage

1. Install chezmoi and age. The installation script can be found [here](scripts/install.sh).

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/yilinfang/dotfiles/main/scripts/install.sh)" | sh
```

The binaries will be installed to `~/.chezmoi/bin/` by default (you can set it by setting `$INSTALL_TARGET_DIR`). Please add this to your `PATH` if it is not already.

2. Install the dotfiles.

```bash
rm -rf ~/.config/chezmoi      # Remove existing chezmoi config
rm -rf ~/.local/share/chezmoi # Remove existing chezmoi data (optional)
chezmoi init --apply yilinfang -S ~/.chezmoi/dotfiles
```
