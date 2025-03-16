# Personal ZSH settings by Yilin Fang

# Symbols
export LANG="en_US.UTF-8"

export EDITOR="vim"
export VISUAL="vim"

# PATH

# Alias
alias eh="vim ~/.ssh/config"
alias ez="vim ~/.zshrc"
alias ua="~/Workspace/update-scripts/update-zsh.sh"

alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -a"
alias lla="lsd -la"
alias lt="lsd --tree"

# Zoxide
eval "$(zoxide init zsh)"

# Zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Starship
eval "$(starship init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/leo/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/leo/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/leo/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/leo/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# nvim-starter configuration
if [ -f /Users/leo/.nvim-starter/init.zsh ]; then
    source /Users/leo/.nvim-starter/init.zsh
fi
