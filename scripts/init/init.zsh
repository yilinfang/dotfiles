# init.zsh
# This script initializes the Zsh shell environment

# Add $HOME/.local/bin to PATH if not already present
path=($HOME/.local/bin $path) # Automatically deduplicates

# If mise is installed, activate it
if command -v mise &>/dev/null; then
	eval "$(mise activate zsh)"
	export MISE_PIPX_UVX=false # Use pipx instead of uvx by default
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

# If t is available, use it for tmux
if ! command -v t &>/dev/null; then
	alias t='tmux'
fi

# If lg is available, use it for lazygit
if command -v lazygit &>/dev/null && ! command -v lg &>/dev/null; then
	alias lg='lazygit'
fi

# Initialize fzf if installed
if command -v fzf &>/dev/null; then
	source <(fzf --zsh)
	if command -v fd &>/dev/null; then
		export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --no-ignore-vcs --hidden --follow'
		export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
		export FZF_ALT_C_COMMAND='fd --type dir --strip-cwd-prefix --no-ignore-vcs --hidden --follow'
	fi
fi

# Initialize zoxide if installed
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init zsh)"
fi

# If y is available, use it for yazi
if command -v yazi &>/dev/null && ! command -v y &>/dev/null; then
	function y() {
		local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
		yazi "$@" --cwd-file="$tmp"
		IFS= read -r -d '' cwd <"$tmp"
		[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
		rm -f -- "$tmp"
	}
fi

# If srm is available, use it for smart-rm
if command -v smart-rm &>/dev/null && ! command -v srm &>/dev/null; then
	alias srm='smart-rm'
	alias srmf='I_UNDERSTAND_WHAT_I_AM_DOING=1 smart-rm -f'
fi
