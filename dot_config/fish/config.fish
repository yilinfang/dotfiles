if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set XDG_CONFIG_HOME to "$HOME/.config"
if test -z "$XDG_CONFIG_HOME"
    set -gx XDG_CONFIG_HOME "$HOME/.config"
end

# MacOS specific configuration
if test (uname) = Darwin
    # Homebrew
    fish_add_path -g /opt/homebrew/bin

    # HACK: Update terminfo database with Homebrew installed ncurses
    set -l ncurses_terminfo (brew --prefix ncurses)/share/terminfo
    if not contains $ncurses_terminfo $TERMINFO_DIRS
        set -gx TERMINFO_DIRS $ncurses_terminfo $TERMINFO_DIRS
    end
end

# Starship
if command -v starship >/dev/null
    starship init fish | source
end

# Zoxide
if command -v zoxide >/dev/null
    zoxide init fish | source
end

# Eza
if command -v eza >/dev/null
    alias ls='Eza --color=always --icons=always --group-directories-first'
    alias l='ls'
    alias la='ls -a'
    alias ll='ls -l --total-size'
    alias lla='ll -a'
    alias lt='ls -l --tree --level=2 --total-size --git'
    alias lta='lt -a'
end

# Fzf
if command -v fzf >/dev/null
    fzf --fish | source
end

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

/Users/leo/.local/bin/mise activate fish | source

if test -f "/Users/leo/.chezmoi/dotfiles/scripts/init/init.fish"
    source "/Users/leo/.chezmoi/dotfiles/scripts/init/init.fish"
end
