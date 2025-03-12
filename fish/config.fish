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

# Starship
starship init fish | source

# Yazi
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
    rm -f -- "$tmp"
end

# Alias
alias ua="~/Workspace/update-scripts/update-fish.sh"
alias ba="~/Workspace/backup-scripts/backup-all.sh"
alias eh="$EDITOR ~/.ssh/config"

alias v="vim"
alias g="git"
alias c="code"
alias t="tmux"

alias ze="zellij"
alias lg="lazygit"

alias cat="bat -p"

alias ls='eza $eza_params'
alias l='eza --git-ignore $eza_params'
alias ll='eza --all --header --long $eza_params'
alias llm='eza --all --header --long --sort=modified $eza_params'
alias la='eza -lbhHigUmuSa'
alias lx='eza -lbhHigUmuSa@'
alias lt='eza --tree $eza_params'

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
