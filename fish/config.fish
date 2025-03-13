if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set editor
set -gx EDITOR vim
set -gx VISUAL vim

# Homebrew
fish_add_path -g /opt/homebrew/bin

# fzf
fzf --fish | source

# zoxide
zoxide init fish | source

# Yazi
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
    rm -f -- "$tmp"
end

# Starship
starship init fish | source

# Alias
alias v="vim"
alias n="nvim"
alias g="git"
alias c="code"
alias t="tmux"

alias ze="zellij"
alias lg="lazygit"

alias cat="bat -p"

alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -a"
alias lla="lsd -la"
alias lt="lsd --tree"

alias bc="brew cleanup"
alias ua="~/Workspace/update-scripts/update-fish.sh"
alias ba="~/Workspace/backup-scripts/backup-all.sh"
alias eh="$EDITOR ~/.ssh/config"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/leo/miniconda3/bin/conda
    eval /Users/leo/miniconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/Users/leo/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/leo/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /Users/leo/miniconda3/bin $PATH
    end
end
# <<< conda initialize <<<
