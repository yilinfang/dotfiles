#!/usr/bin/env bash
# Create splits in a tmux window in a horizontal layout

tmux split-window -v
tmux split-window -h -b -t 1
tmux split-window -h -b -t 2
tmux split-window -h -b -t 1
tmux select-pane -t 0 # Focus back to the first pane
