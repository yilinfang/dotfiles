# init.sh
# This script initializes the Bash shell environment

# If mise is installed, activate it
if command -v mise &>/dev/null; then
	eval "$(mise activate bash)"
fi

# If nvim is installed, set it as the default editor
if command -v nvim &>/dev/null; then
	export EDITOR=nvim
	export VISUAL=nvim
	# If n is available, use it for nvim
	if ! command -v n &>/dev/null; then
		alias n='nvim'
	fi
fi

# If rg is installed
if command -v rg &>/dev/null; then
	export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
	alias rgv='rg --vimgrep'
fi

# If bat or delta is installed, set BAT_THEME
if command -v bat &>/dev/null || command -v delta &>/dev/null; then
	export BAT_THEME="ansi"
fi

# If g is available, use if for Git
if ! command -v g &>/dev/null; then
	alias g='git'
fi

# If lg is available, use it for lazygit
if command -v lazygit &>/dev/null && ! command -v lg &>/dev/null; then
	alias lg='lazygit'
fi

# If ze is available, use it for zellij
if command -v zellij &>/dev/null && ! command -v ze &>/dev/null; then
	alias ze='zellij'
fi

# Initialize fzf if installed
if command -v fzf &>/dev/null; then
	eval "$(fzf --bash)"
	if command -v fd &>/dev/null; then
		export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --unrestricted --follow --exclude .git'
		export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
		export FZF_ALT_C_COMMAND='fd --type dir --strip-cwd-prefix --unrestricted --follow --exclude .git'
	fi
fi

# Initialize zoxide if installed
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init bash)"
fi

# If y is available, initialize yazi
if command -v yazi &>/dev/null && ! command -v y &>/dev/null; then
	alias y='yazi'
fi

# --- Additional configurations for solarized-dark themes ---
if command -v difft &>/dev/null; then # Check if difft is installed
	export DFT_BACKGROUND="light"
fi
