if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Homebrew
fish_add_path -g /opt/homebrew/bin

# Starship
starship init fish | source

# Alias
alias eh="vim ~/.ssh/config"

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

# pde-starter configuration
if test -f /Users/leo/.pde/init.fish
    source /Users/leo/.pde/init.fish
end
