#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/common.sh"

toggle_status_line_style() {
    # Get the current status and update accordingly.
    local dark_mode=$(get_tmux_option "@dark-mode")
    if [[ $dark_mode == "on" ]] ; then
        set_light_mode
    else
        set_dark_mode
    fi
}
toggle_status_line_style
