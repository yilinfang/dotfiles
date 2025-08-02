# init.fish
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

# If rg is installed
if command -v rg >/dev/null
    set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"
    alias rgv='rg --vimgrep'
end

# If bat or delta is installed, set BAT_THEME
if command -v bat >/dev/null or command -v delta >/dev/null
    set -gx BAT_THEME ansi
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
    if command -v fd >/dev/null
        set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --unrestricted --follow --exclude .git'
        set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
        set -gx FZF_ALT_C_COMMAND 'fd --type dir --strip-cwd-prefix --unrestricted --follow --exclude .git'
    end
end

# Initialize starship if installed
if command -v starship >/dev/null
    starship init fish | source
end

# Initialize zoxide if installed
if command -v zoxide >/dev/null
    zoxide init fish | source
end

# If y is available, initialize yazi
if command -v yazi >/dev/null; and not command -v y >/dev/null
    alias y='yazi'
end
