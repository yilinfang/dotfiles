# init.fsh
# This script initializes the Fish shell environment

# If mise is installed, activate it
if command -v mise >/dev/null
    mise activate fish | source
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

# If rg(ripgrep) is installed and the RIPGREP_CONFIG_PATH is not set, set it
if command -v rg >/dev/null; and not set -q RIPGREP_CONFIG_PATH
    set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"
end

# If g is available, use if for Git
if not command -v g >/dev/null
    alias g='git'
end

# If lg is available, use it for lazygit
if command -v lazygit >/dev/null; and not command -v lg >/dev/null
    alias lg='lazygit'
end

# If ze is available, use it for zellij
if command -v zellij >/dev/null; and not command -v ze >/dev/null
    alias ze='zellij'
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

# --- Additional configurations for solarized-dark themes ---
if command -v bat >/dev/null # Check if bat is installed
    set -gx BAT_THEME "Solarized (dark)"
end
if command -v delta >/dev/null # Check if delta is installed
    set -gx BAT_THEME "Solarized (dark)"
end
if command -v difft >/dev/null # Check if difft is installed
    set -gx DFT_BACKGROUND light
end
