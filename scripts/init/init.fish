# init.fsh
# This script initializes the Fish shell environment

# Add ~/.local/bin to the PATH if it exists
if test -d "$HOME/.local/bin"
    fish_add_path -g "$HOME/.local/bin"
end

# If nvim is installed, set it as the default editor
if command -v nvim >/dev/null
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    # If n is available, use it for nvim
    if not command -v n >/dev/null
        alias n='nvim'
    end
end

# If g is available, use if for Git
if not command -v g >/dev/null
    alias g='git'
end

# If t is available, use it for tmux
if not command -v t >/dev/null
    alias t='tmux'
end

# If lg is available, use it for lazygit
if command -v lazygit >/dev/null; and not command -v lg >/dev/null
    alias lg='lazygit'
end

# Initialize fzf if installed
if command -v fzf >/dev/null
    fzf --fish | source
end

# Initialize zoxide if installed
if command -v zoxide >/dev/null
    zoxide init fish | source
end

# If y is available, initialize yazi
if command -v yazi >/dev/null; and not command -v y >/dev/null
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"

    end
end

# --- Patch for solarized dark themes ---
# Set BAT_THEME for bat if it is installed
if command -v bat >/dev/null
    set -gx BAT_THEME "Solarized (dark)"
end
# Set DFT_BACKGROUND to light if difft is installed
if command -v difft >/dev/null
    set -gx DFT_BACKGROUND light
end
# --- End of patch for solarized dark themes ---
