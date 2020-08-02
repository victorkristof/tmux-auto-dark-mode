#!/usr/bin/env bash

# Enable debug mode.
# set -x

# Set options.
tmux set-option -gq @status-line-dark  "/Users/kristof/.dotfiles/tmux-status-line-dark.conf"
tmux set-option -gq @status-line-light "/Users/kristof/.dotfiles/tmux-status-line-light.conf"
tmux set-option -gq @iterm "on"

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/common.sh"

# Bind keys to manually toggle between status line styles.
tmux bind-key T run-shell "$CURRENT_DIR/scripts/toggle-dark-mode.sh"

main() {
    # Tmux updates its status line every 15 seconds by default,
    # which enables to check the system interface style and adapts
    # the status line accordingly by adding a script to the status line.
    set_tmux_option "@dark-mode" ""
    set_status_right_value
}
main
