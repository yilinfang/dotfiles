if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Homebrew
fish_add_path -g /opt/homebrew/bin

# WezTerm CLI
fish_add_path -g /Applications/WezTerm.app/Contents/MacOS

# Starship
starship init fish | source

# Zoxide
zoxide init fish | source

# Alias
alias ua="~/Workspace/update-scripts/update-fish.sh"
alias ba="~/Workspace/backup-scripts/backup-all.sh"
alias eh="vim ~/.ssh/config"

alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -a"
alias lla="lsd -la"
alias lt="lsd --tree"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/leo/miniconda3/bin/conda
    eval /Users/leo/miniconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/Users/leo/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/leo/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /Users/leo/miniconda3/bin $PATH
    end
end
# <<< conda initialize <<<

# nvim-starter configuration
if test -f /Users/leo/.nvim-starter/init.fish
    source /Users/leo/.nvim-starter/init.fish
end
