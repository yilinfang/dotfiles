if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Homebrew
fish_add_path -g /opt/homebrew/bin

# Zoxide
zoxide init fish | source

# Starship
starship init fish | source

# Alias
alias ua="~/Workspace/update-scripts/update-fish.sh"
alias ba="~/Workspace/backup-scripts/backup-all.sh"
alias eh="vim ~/.ssh/config"

# Eza
# Modified from https://github.com/basecamp/omakub/blob/master/defaults/bash/aliases
alias ls='eza --color=always --icons=always --group-directories-first'
alias l='ls'
alias la='ls -a'
alias ll='ls -lh --total-size'
alias lla='ll -a'
alias lt='ls -lT --level=2 --total-size --git'
alias lta='lt -a'

# Functions
function update_terminal_info
    # Check if a server argument is provided
    if test -z "$argv"
        echo "Usage: update_terminal_info <server>"
        return 1
    end

    # Run the command with the provided server argument
    infocmp -x | ssh $argv -- tic -x -
end


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
