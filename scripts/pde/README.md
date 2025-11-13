# Scripts for Setting up PDE

## Usage

```bash
# Install mise if you don't have it
curl https://mise.run | sh
# Remove existing chezmoi config
rm -rf ~/.config/chezmoi
# Remove existing chezmoi data
rm -rf ~/.local/share/chezmoi
rm -rf ~/.chezmoi/dotfiles
# Install dotfiles
IS_PDE=true mise exec age chezmoi -- chezmoi init --apply https://github.com/yilinfang/dotfiles.git -S ~/.chezmoi/dotfiles
# Setup shell
mise exec chezmoi -- chezmoi cd
bash scripts/pde/setup-shell.sh
# Optional
bash scripts/pde/setup-git.sh
bash scripts/pde/build-git-linux.sh
bash scripts/pde/build-tmux-linux.sh
```

### Via make

### Install via make

```bash
# Remove existing chezmoi config
rm -rf ~/.config/chezmoi
# Remove existing chezmoi data
rm -rf ~/.local/share/chezmoi
rm -rf ~/.chezmoi/dotfiles
# Download dotfiles via git
git clone https://github.com/yilinfang/dotfiles.git ~/.chezmoi/dotfiles
# Install dotfiles
cd ~/.chezmoi/dotfiles
make pde_install
```
