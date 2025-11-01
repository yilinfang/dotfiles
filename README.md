# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

_NOTE: I may occasionally create conflicts in this repository by force pushing or rewriting history._
_This happens when I accidentally commit some sensitive data._

## Usage

### Install tools

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/yilinfang/dotfiles/refs/heads/main/scripts/install.sh)
```

### Install dotfiles

```bash
# Remove existing chezmoi config
rm -rf ~/.config/chezmoi
# Remove existing chezmoi data
rm -rf ~/.local/share/chezmoi
rm -rf ~/.chezmoi/dotfiles
# Install dotfiles
chezmoi init --apply https://github.com/yilinfang/dotfiles.git -S ~/.chezmoi/dotfiles
# Setup shell
chezmoi cd
bash scripts/pde/setup-shell.sh
```

### Install via mise

```bash
# Install mise if you don't have it
curl https://mise.run | sh
# Remove existing chezmoi config
rm -rf ~/.config/chezmoi
# Remove existing chezmoi data
rm -rf ~/.local/share/chezmoi
rm -rf ~/.chezmoi/dotfiles
# Install dotfiles
mise exec age chezmoi -- chezmoi init --apply https://github.com/yilinfang/dotfiles.git -S ~/.chezmoi/dotfiles
# Setup shell
mise exec chezmoi -- chezmoi cd
bash scripts/pde/setup-shell.sh
```
