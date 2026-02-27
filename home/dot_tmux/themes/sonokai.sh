#!/usr/bin/env bash
# Theme Sonokai for tmux
# Modified from tokyonight.nvim's tmux extra

# Define colors
# From: https://github.com/sainnhe/sonokai
# Group Default
FG_DEFAULT="#e2e2e3"
BG_DEFAULT="#33353f"
# Group Highlight 1
FG_HIGHLIGHT_1="#2c2e34"
BG_HIGHLIGHT_1="#85d3f2"
# Group Highlight 2
FG_HIGHLIGHT_2="#85d3f2"
BG_HIGHLIGHT_2="#414550"

tmux set -g mode-style "fg=${FG_HIGHLIGHT_1},bg=${BG_HIGHLIGHT_1}"

tmux set -g message-style "fg=${FG_HIGHLIGHT_1},bg=${BG_HIGHLIGHT_1}"
tmux set -g message-command-style "fg=${FG_HIGHLIGHT_1},bg=${BG_HIGHLIGHT_1}"

tmux set -g pane-border-style "fg=${BG_HIGHLIGHT_2}"
tmux set -g pane-active-border-style "fg=${BG_HIGHLIGHT_1}"

tmux set -g menu-style "fg=${BG_HIGHLIGHT_1}"
tmux set -g menu-selected-style "fg=${FG_HIGHLIGHT_1},bg=${BG_HIGHLIGHT_1},bold"
tmux set -g menu-border-style "fg=${BG_HIGHLIGHT_1}"

tmux set -g clock-mode-style "24" # NOTE: "12" or "24" for 12-hour or 24-hour format
tmux set -g clock-mode-colour "${BG_HIGHLIGHT_1}"

tmux set -g status "on"
tmux set -g status-justify "left"

tmux set -g status-style "fg=${FG_DEFAULT},bg=${BG_DEFAULT}"

tmux set -g status-left-length "100"
tmux set -g status-right-length "100"

tmux set -g status-left-style NONE
tmux set -g status-right-style NONE

STATUS_LEFT=""
STATUS_LEFT+="#[fg=${FG_HIGHLIGHT_1},bg=${BG_HIGHLIGHT_1},bold] #S "
STATUS_LEFT+="#[fg=${BG_HIGHLIGHT_1},bg=${BG_DEFAULT},nobold,nounderscore,noitalics]"
tmux set -g status-left "$STATUS_LEFT"

STATUS_RIGHT=""
STATUS_RIGHT+="#[fg=${BG_DEFAULT},bg=${BG_DEFAULT},nobold,nounderscore,noitalics]"
STATUS_RIGHT+="#[fg=${FG_DEFAULT},bg=${BG_DEFAULT}] #{prefix_highlight} "
STATUS_RIGHT+="#[fg=${BG_HIGHLIGHT_2},bg=${BG_DEFAULT},nobold,nounderscore,noitalics]"
STATUS_RIGHT+="#[fg=${FG_HIGHLIGHT_2},bg=${BG_HIGHLIGHT_2}] #(whoami) "
STATUS_RIGHT+="#[fg=${BG_HIGHLIGHT_1},bg=${BG_HIGHLIGHT_2},nobold,nounderscore,noitalics]"
STATUS_RIGHT+="#[fg=${FG_HIGHLIGHT_1},bg=${BG_HIGHLIGHT_1},bold] #h "
tmux set -g status-right "$STATUS_RIGHT"

tmux setw -g window-status-activity-style "underscore,fg=${FG_DEFAULT},bg=${BG_DEFAULT}"
tmux setw -g window-status-separator ""
tmux setw -g window-status-style "NONE,fg=${FG_DEFAULT},bg=${BG_DEFAULT}"
WINDOW_STATUS_FORMAT=""
WINDOW_STATUS_FORMAT+="#[fg=${BG_DEFAULT},bg=${BG_DEFAULT},nobold,nounderscore,noitalics]"
WINDOW_STATUS_FORMAT+="#[default] #I  #W #F "
WINDOW_STATUS_FORMAT+="#[fg=${BG_DEFAULT},bg=${BG_DEFAULT},nobold,nounderscore,noitalics]"
tmux setw -g window-status-format "$WINDOW_STATUS_FORMAT"
WINDOW_STATUS_CURRENT_FORMAT=""
WINDOW_STATUS_CURRENT_FORMAT+="#[fg=${BG_DEFAULT},bg=${BG_HIGHLIGHT_2},nobold,nounderscore,noitalics]"
WINDOW_STATUS_CURRENT_FORMAT+="#[fg=${FG_HIGHLIGHT_2},bg=${BG_HIGHLIGHT_2},bold] #I  #W #F "
WINDOW_STATUS_CURRENT_FORMAT+="#[fg=${BG_HIGHLIGHT_2},bg=${BG_DEFAULT},nobold,nounderscore,noitalics]"
tmux setw -g window-status-current-format "$WINDOW_STATUS_CURRENT_FORMAT"
