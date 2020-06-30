#!/bin/bash

tmux new-session -s procrastinate -n git -d
tmux send-keys -t procrastinate:git 'cd ~/src/procrastinate && vex main docker-compose up -d postgres && vex main' C-m

tmux new-window -n edit
tmux send-keys -t procrastinate:edit 'cd ~/src/procrastinate && vex main' C-m

tmux new-window -n test
tmux send-keys -t procrastinate:test 'cd ~/src/procrastinate && PGHOST=localhost PGUSER=postgres PGPASSWORD=password PGDATABASE=procrastinate vex procrastinate' C-m

tmux new-window -n psql
tmux send-keys -t procrastinate:psql 'cd ~/src/procrastinate && sleep 3 && PGHOST=localhost PGUSER=postgres PGPASSWORD=password PGDATABASE=procrastinate psql' C-m

tmux select-window -t git
tmux attach -t procrastinate
