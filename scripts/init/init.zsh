# init.zsh
# This script initializes the Zsh shell environment

# Add ~/.local/bin to the PATH if it exists
if [[ -d "$HOME/.local/bin" ]]; then
  path=("$HOME/.local/bin" $path)
fi

# If nvim is installed, set it as the default editor
if command -v nvim &> /dev/null; then
    export EDITOR=nvim
    export VISUAL=nvim
    # If n is available, use it for nvim
    if ! command -v n &> /dev/null; then
        alias n='nvim'
    fi
fi

# If g is available, use if for Git
if ! command -v g &> /dev/null; then
    alias g='git'
fi

# If t is available, use it for tmux
if ! command -v t &> /dev/null; then
    alias t='tmux'
fi

# If lg is available, use it for lazygit
if command -v lazygit &> /dev/null && ! command -v lg &> /dev/null; then
    alias lg='lazygit'
fi

# Initialize fzf if installed
if command -v fzf &> /dev/null; then
    source <(fzf --zsh)
fi

# Initialize zoxide if installed
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# If y is available, initialize yazi
if command -v yazi &> /dev/null && ! command -v y &> /dev/null; then
    function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if [[ -f "$tmp" ]]; then
            local cwd="$(cat -- "$tmp")"
            rm -f -- "$tmp"
            if [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
                cd -- "$cwd"
            fi
        fi
    }
fi

# --- Patch for solarized dark themes ---
# Set BAT_THEME for bat if it is installed
if command -v bat &> /dev/null; then
    export BAT_THEME="Solarized (dark)"
fi
# Set DFT_BACKGROUND to light if difft is installed
if command -v difft &> /dev/null; then
    export DFT_BACKGROUND=light
fi
# --- End of patch for solarized dark themes ---
