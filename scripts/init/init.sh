# init.sh
# This script initializes the Bash shell environment

# If mise is installed, activate it
if command -v mise &>/dev/null; then
	eval "$(mise init bash)"
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

# If rg(ripgrep) is installed and the RIPGREP_CONFIG_PATH is not set, set it
if command -v rg &>/dev/null && [ -z "${RIPGREP_CONFIG_PATH:-}" ]; then
	export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
fi

# If g is available, use if for Git
if ! command -v g &>/dev/null; then
	alias g='git'
fi

# If t is available, use it for tmux
if ! command -v t &>/dev/null; then
	alias t='tmux'
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
fi

# Initialize zoxide if installed
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init bash)"
fi

# If y is available, initialize yazi
if command -v yazi &>/dev/null && ! command -v y &>/dev/null; then
	function y() {
		local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
		yazi "$@" --cwd-file="$tmp"
		IFS= read -r -d '' cwd <"$tmp"
		[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
		rm -f -- "$tmp"
	}
fi

# --- Additional configurations for solarized-dark themes ---
if command -v bat &>/dev/null; then # Check if bat is installed
	export BAT_THEME="Solarized (dark)"
fi
if command -v difft &>/dev/null; then # Check if difft is installed, set the theme
	export BAT_THEME="Solarized (dark)"
	export DFT_BACKGROUND="light"
fi
