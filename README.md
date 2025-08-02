# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Usage

### Install chezmoi

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/yilinfang/dotfiles/refs/heads/main/scripts/install.sh)
```

### Install dotfiles

```bash
# Remove existing chezmoi config
rm -rf ~/.config/chezmoi
# Remove existing chezmoi data (optional)
rm -rf ~/.local/share/chezmoi
# Install dotfiles
chezmoi init --apply yilinfang -S ~/.chezmoi/dotfiles
```
