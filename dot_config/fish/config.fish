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

# Add $HOME/.chezmoi/bin to PATH if it exists
if test -d "$HOME/.chezmoi/bin"
    fish_add_path "$HOME/.chezmoi/bin"
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

# pde-starter configuration
if test -f /Users/leo/.pde/init.fish
    source /Users/leo/.pde/init.fish
end
