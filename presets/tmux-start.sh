#!/bin/env bash

SESSION_NAME="NAME"

# Start a new tmux session (detached)
tmux new-session -d -s "${SESSION_NAME}"

tmux rename-window -t "${SESSION_NAME}":1 "NAME"
tmux send-keys -t "${SESSION_NAME}":1 "COMMAND" C-m

tmux new-window -t "${SESSION_NAME}" -n "NAME"
tmux send-keys -t "${SESSION_NAME}":2 "COMMAND" C-m

[ -z "$TMUX" ] && tmux attach-session -t "${SESSION_NAME}"
