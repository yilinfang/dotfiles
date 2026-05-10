#!/usr/bin/env bash
# Create splits in a tmux window in a vertical layout

tmux split-window -h
tmux split-window -v -b -t 1
tmux split-window -v -b -t 2
tmux split-window -v -b -t 1
tmux select-pane -t 0 # Focus back to the first pane
