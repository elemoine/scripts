#!/bin/bash

tmux new-session -s doc-classif -n git -d
tmux send-keys -t doc-classif:git 'cd ~/src/doc-classif && vex main' C-m

tmux new-window -n edit
tmux send-keys -t doc-classif:edit 'cd ~/src/doc-classif && vex main' C-m

tmux new-window -n venv
tmux send-keys -t doc-classif:venv 'cd ~/src/doc-classif && source .venv/bin/activate' C-m

tmux select-window -t git
tmux attach -t doc-classif
