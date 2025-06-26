# init.sh
# This script initializes the Bash shell environment

# Add ~/.local/bin to PATH if it exists and is not already there
if [ -d "$HOME/.local/bin" ]; then
  # Use a case statement to avoid substring matching issues and extra processes.
  # We check for the path surrounded by colons.
  case ":$PATH:" in
  *:"$HOME/.local/bin":*)
    # The path is already in the PATH string. Do nothing.
    ;;
  *)
    # Prepend the path to the PATH string.
    export PATH="$HOME/.local/bin:$PATH"
    ;;
  esac
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
if [ -f ~/.fzf.bash ]; then
  eval "$(fzf --bash)"
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

# --- Patch for solarized dark themes ---
# Set BAT_THEME for bat if it is installed
if command -v bat &>/dev/null; then
  export BAT_THEME="Solarized (dark)"
fi
# Set DFT_BACKGROUND to light if difft is installed
if command -v difft &>/dev/null; then
  export DFT_BACKGROUND=light
fi
# --- End of patch for solarized dark themes ---
