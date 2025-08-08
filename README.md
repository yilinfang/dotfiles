# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Usage

### Install tools

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
chezmoi init --apply https://github.com/yilinfang/dotfiles.git -S ~/.chezmoi/dotfiles
```
