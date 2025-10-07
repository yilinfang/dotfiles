# init.zsh
# This script initializes the Zsh shell environment

# Add $HOME/.local/bin to PATH if not already present
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

# If mise is installed, activate it
if command -v mise &>/dev/null; then
	eval "$(mise activate zsh)"
	export MISE_PIPX_UVX=false # Use pipx instead of uvx by default
fi

# If nvim is installed, set it as the default editor
if command -v nvim &>/dev/null; then
	export EDITOR=nvim
	export VISUAL=nvim
	alias n='nvim'
fi

# If rg is installed
if command -v rg &>/dev/null; then
	export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
	alias rgv='rg --vimgrep'
	alias brg='rg --smart-case --max-columns=150 --max-columns-preview'
fi

# If bat is installed
if command -v bat &>/dev/null; then
	alias bcat='bat --color=always --paging=never --style=plain'
fi

# If bat or delta is installed, set BAT_THEME
if command -v bat &>/dev/null || command -v delta &>/dev/null; then
	export BAT_THEME="ansi"
fi

# Use g for git
if command -v git &>/dev/null; then
	alias g='git'
fi

# Use t for tmux
if command -v tmux &>/dev/null; then
	alias t='tmux'
fi

# Use lg for lazygit
if command -v lazygit &>/dev/null; then
	alias lg='lazygit'
fi

# # Use zj for zellij
# if command -v zellij &>/dev/null; then
# 	alias zj='zellij'
# fi

# # Use y for yazi
# if command -v yazi &>/dev/null; then
# 	function y() {
# 		local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
# 		yazi "$@" --cwd-file="$tmp"
# 		IFS= read -r -d '' cwd <"$tmp"
# 		[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
# 		rm -f -- "$tmp"
# 	}
# fi

# Create wrapper for lf
if command -v lf &>/dev/null; then
	function lf() {
		local last_dir
		last_dir=$(
			LF_OLD_PWD="$PWD" \
				command lf -print-last-dir "$@"
		)
		if [ -n "$last_dir" ] && [ -d "$last_dir" ]; then
			builtin cd -- "$last_dir" || return
		fi
	}
fi

# Initialize fzf if installed
if command -v fzf &>/dev/null; then
	source <(fzf --zsh)

	# Check for fd or fdfind command
	if command -v fdfind &>/dev/null; then
		FD_COMMAND='fdfind'
	elif command -v fd &>/dev/null; then
		FD_COMMAND='fd'
	fi

	# Set up fzf commands if fd/fdfind is available
	if [[ -n "$FD_COMMAND" ]]; then
		export FZF_DEFAULT_COMMAND="$FD_COMMAND --strip-cwd-prefix --no-ignore-vcs --hidden"
		export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
		export FZF_ALT_C_COMMAND="$FD_COMMAND --type dir --strip-cwd-prefix --no-ignore-vcs --hidden"
	fi
fi

# Initialize zoxide if installed
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init zsh)"
fi
