if status is-interactive
    # Commands to run in interactive sessions can go here
end
# Set XDG_CONFIG_HOME to "$HOME/.config"
if test -z "$XDG_CONFIG_HOME"
    set -gx XDG_CONFIG_HOME "$HOME/.config"
end

# Add ~/.local/bin to PATH if it exists
if test -d "$HOME/.local/bin"
    fish_add_path -g "$HOME/.local/bin"
end

# MacOS specific configuration
if test (uname) = Darwin
    # Homebrew
    fish_add_path -g /opt/homebrew/bin
end

# Eza
if command -v eza >/dev/null
    alias ls='eza --color=always --icons=always --group-directories-first'
    alias l='ls'
    alias la='ls -a'
    alias ll='ls -l --total-size'
    alias lla='ll -a'
    alias lt='ls -l --tree --level=2 --total-size --git'
    alias lta='lt -a'
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

if test -f "/Users/leo/.chezmoi/dotfiles/scripts/init/init.fish"
    source "/Users/leo/.chezmoi/dotfiles/scripts/init/init.fish"
end
