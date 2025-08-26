# init.fish
# This script initializes the Fish shell environment

# Add $HOME/.local/bin to PATH if not already present
fish_add_path -g $HOME/.local/bin # Automatically deduplicates

# If mise is installed, activate it
if command -v mise >/dev/null
    mise activate fish | source
    set -gx MISE_PIPX_UVX false # Use pipx instead of uvx by default
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
    if command -v fd >/dev/null
        set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --no-ignore-vcs --hidden --follow'
        set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
        set -gx FZF_ALT_C_COMMAND 'fd --type dir --strip-cwd-prefix --no-ignore-vcs --hidden --follow'
    end
end

# Initialize zoxide if installed
if command -v zoxide >/dev/null
    zoxide init fish | source
end

# If y is available, use it for yazi
if command -v yazi >/dev/null; and not command -v y >/dev/null
    function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
	    builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
    end
end

# If srm is available, use it for smart-rm
if command -v smart-rm >/dev/null; and not command -v srm >/dev/null
    alias srm='smart-rm'
    alias srmf='I_UNDERSTAND_WHAT_I_AM_DOING=1 smart-rm'
end
