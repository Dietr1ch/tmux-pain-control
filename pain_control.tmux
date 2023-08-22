#!/usr/bin/env bash

default_pane_resize="5"

# tmux show-option "q" (quiet) flag does not set return value to 1, even though
# the option does not exist. This function patches that.
get_tmux_option() {
	local option=$1
	local default_value=$2
	local option_value=$(tmux show-option -gqv "$option")
	if [ -z $option_value ]; then
		echo $default_value
	else
		echo $option_value
	fi
}

# Window
# ------
# Move
tmux bind-key -r "<" swap-window -d -t -1
tmux bind-key -r ">" swap-window -d -t +1
# Improve new window
tmux bind-key "c" new-window -c "#{pane_current_path}"

# Pane
# ----
# Navigation
tmux bind-key h select-pane -L
tmux bind-key j select-pane -D
tmux bind-key k select-pane -U
tmux bind-key l select-pane -R
# Resizing
local pane_resize=$(get_tmux_option "@pane_resize" "$default_pane_resize")
tmux bind-key -r H resize-pane -L "$pane_resize"
tmux bind-key -r J resize-pane -D "$pane_resize"
tmux bind-key -r K resize-pane -U "$pane_resize"
tmux bind-key -r L resize-pane -R "$pane_resize"
# Split
tmux bind-key "|"  split-window -h  -c "#{pane_current_path}"
tmux bind-key "\\" split-window -fh -c "#{pane_current_path}"
tmux bind-key "-"  split-window -v  -c "#{pane_current_path}"
tmux bind-key "_"  split-window -fv -c "#{pane_current_path}"
tmux bind-key "%"  split-window -h  -c "#{pane_current_path}"
tmux bind-key '"'  split-window -v  -c "#{pane_current_path}"

