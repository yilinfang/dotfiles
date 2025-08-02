#!/usr/bin/env bash
# Setup the statusline for tmux with ansi colors
# Modified from tokyonight.nvim's tmux extra

# Define colors
# Group Default
FG_DEFAULT="color2"
BG_DEFAULT="color0"
# Group Highlight 1
FG_HIGHLIGHT_1="color0"
BG_HIGHLIGHT_1="color7"
# Group Highlight 2
FG_HIGHLIGHT_2="color0"
BG_HIGHLIGHT_2="color2"

tmux set -g mode-style "fg=${FG_HIGHLIGHT_2},bg=${BG_HIGHLIGHT_2}"

tmux set -g message-style "fg=${FG_HIGHLIGHT_2},bg=${BG_HIGHLIGHT_2}"
tmux set -g message-command-style "fg=${FG_HIGHLIGHT_2},bg=${BG_HIGHLIGHT_2}"

tmux set -g pane-border-style "fg=${FG_HIGHLIGHT_2}"
tmux set -g pane-active-border-style "fg=${BG_HIGHLIGHT_2}"

tmux set -g menu-style "fg=${FG_DEFAULT}"
tmux set -g menu-selected-style "fg=${FG_HIGHLIGHT_2},bg=${BG_HIGHLIGHT_2},bold"
tmux set -g menu-border-style "fg=${FG_DEFAULT}"

tmux set -g clock-mode-style "12"
tmux set -g clock-mode-colour "${FG_DEFAULT}"

tmux set -g status "on"
tmux set -g status-justify "left"

tmux set -g status-style "fg=${FG_DEFAULT},bg=${BG_DEFAULT}"

tmux set -g status-left-length "100"
tmux set -g status-right-length "100"

tmux set -g status-left-style NONE
tmux set -g status-right-style NONE

tmux set -g status-left "#[fg=${FG_HIGHLIGHT_1},bg=${BG_HIGHLIGHT_1},bold] #S #[fg=${BG_HIGHLIGHT_1},bg=${BG_DEFAULT},nobold,nounderscore,noitalics]"
CLOCK_MODE_STYLE=$(tmux show-option -gqv "clock-mode-style" 2>/dev/null)
if [ "$CLOCK_MODE_STYLE" == "24" ]; then
  tmux set -g status-right "#[fg=${BG_DEFAULT},bg=${BG_DEFAULT},nobold,nounderscore,noitalics]#[fg=${FG_DEFAULT},bg=${BG_DEFAULT}] #{prefix_highlight} #[fg=${BG_HIGHLIGHT_2},bg=${BG_DEFAULT},nobold,nounderscore,noitalics]#[fg=${FG_HIGHLIGHT_2},bg=${BG_HIGHLIGHT_2}] %Y-%m-%d  %H:%M #[fg=${BG_HIGHLIGHT_1},bg=${BG_HIGHLIGHT_2},nobold,nounderscore,noitalics]#[fg=${FG_HIGHLIGHT_1},bg=${BG_HIGHLIGHT_1},bold] #h "
else
  tmux set -g status-right "#[fg=${BG_DEFAULT},bg=${BG_DEFAULT},nobold,nounderscore,noitalics]#[fg=${FG_DEFAULT},bg=${BG_DEFAULT}] #{prefix_highlight} #[fg=${BG_HIGHLIGHT_2},bg=${BG_DEFAULT},nobold,nounderscore,noitalics]#[fg=${FG_HIGHLIGHT_2},bg=${BG_HIGHLIGHT_2}] %Y-%m-%d  %I:%M %p #[fg=${BG_HIGHLIGHT_1},bg=${BG_HIGHLIGHT_2},nobold,nounderscore,noitalics]#[fg=${FG_HIGHLIGHT_1},bg=${BG_HIGHLIGHT_1},bold] #h "
fi

tmux setw -g window-status-activity-style "underscore,fg=${FG_DEFAULT},bg=${BG_DEFAULT}"
tmux setw -g window-status-separator ""
tmux setw -g window-status-style "NONE,fg=${FG_DEFAULT},bg=${BG_DEFAULT}"
tmux setw -g window-status-format "#[fg=${BG_DEFAULT},bg=${BG_DEFAULT},nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=${BG_DEFAULT},bg=${BG_DEFAULT},nobold,nounderscore,noitalics]"
tmux setw -g window-status-current-format "#[fg=${BG_DEFAULT},bg=${BG_HIGHLIGHT_2},nobold,nounderscore,noitalics]#[fg=${FG_HIGHLIGHT_2},bg=${BG_HIGHLIGHT_2},bold] #I  #W #F #[fg=${BG_HIGHLIGHT_2},bg=${BG_DEFAULT},nobold,nounderscore,noitalics]"
