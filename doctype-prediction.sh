#!/bin/bash

tmux new-session -s doctype-prediction -n git -d
tmux send-keys -t doctype-prediction:git 'cd ~/src/doctype-prediction && vex main' C-m

tmux new-window -n edit
tmux send-keys -t doctype-prediction:edit 'cd ~/src/doctype-prediction && vex main' C-m

tmux new-window -n venv
tmux send-keys -t doctype-prediction:venv 'cd ~/src/doctype-prediction && source .venv/bin/activate' C-m

tmux select-window -t git
tmux attach -t doctype-prediction
