#!/usr/bin/env bash
# Create splits in a tmux window in a vertical layout

tmux split-window -h
tmux split-window -v -t 1
tmux split-window -v -t 1
tmux split-window -v -t 3
tmux select-pane -t 0
