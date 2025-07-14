# Scripts for Setting up PDE

## Usage

```bash
# Install
bash <(curl -fsSL https://raw.githubusercontent.com/yilinfang/dotfiles/refs/heads/main/scripts/install.sh)
rm -rf ~/.config/chezmoi
rm -rf ~/.local/share/chezmoi
chezmoi init yilinfang -S ~/.chezmoi/dotfiles
chezmoi cd
cd scripts/pde
bash ./install-mise.sh
bash ./install-tools-with-mise.sh
bash ./setup-shell.sh
bash ./setup-config.sh
# Update
bash ./update-config.sh
# Optional
bash ./setup-git.sh
bash ./build-tmux-linux.sh
```
