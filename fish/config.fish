if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Homebrew (only on macOS)
if test (uname) = Darwin
    fish_add_path -g /opt/homebrew/bin
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

# Alias
alias eh="vi $HOME/.ssh/config"

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
