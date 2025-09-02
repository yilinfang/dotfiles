#!/usr/bin/env bash
# Create splits in a tmux window in a horizontal layout

tmux split-window -v
tmux split-window -h -t 1
tmux split-window -h -t 1
tmux split-window -h -t 3
tmux select-pane -t 0
