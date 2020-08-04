#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/common.sh"

get_system_mode() {
    # Check status of dark mode (ignore errors, i.e., when light mode is enabled).
    local status="$(defaults read -g AppleInterfaceStyle 2>/dev/null)"
    # Return system mode.
    if [[ $status == "Dark" ]] ; then
        echo "dark"
    else
        echo "light"
    fi
}

set_status_line_style() {
    local current_mode="$(get_tmux_option "@adm-current-mode" "")"
    local new_mode="$(get_system_mode)"
    # The first time this script is run, we don't which mode is enabled.
    if [[ $current_mode == "" ]] ; then
        if [[ $new_mode == "dark" ]] ; then
            set_dark_mode
        else
            set_light_mode
        fi
    fi

    # Then, we set the status line style based on which mode is activated, only when it has changed.
    if [[ $new_mode == "dark" && $current_mode == "light" ]] ; then
        set_dark_mode
    elif [[ $new_mode == "light" && $current_mode == "dark" ]] ; then
        set_light_mode
    fi
}
set_status_line_style
