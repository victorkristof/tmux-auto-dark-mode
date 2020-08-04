#!/usr/bin/env bash

get_tmux_option() {
    # Read tmux option with default value.
    local option="$1"
    local default_value="$2"
    local option_value=$(tmux show-option -gqv "$option")
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

set_tmux_option() {
    # Set value to option.
    local option="$1"
    local value="$2"
    tmux set-option -gq "$option" "$value"
}

set_status_right_value() {
    # Store current value of status-right.
    local status_right_value="$(get_tmux_option "status-right" "")"
    # Check if Continuum is installed.
    local continuum_command=""
    if [[ "$status_right_value" == *continuum_save.sh* ]]; then
        # Extract command for Continuum script.
        continuum_command="$(echo $status_right_value | perl -nle 'if (/.*(#\(.*?continuum_save.sh\)).*/) {print "$1";}')"
    fi

    # If an argument is given, source this file.
    if [[ $# -eq 1 ]] ; then
        # Load status line config.
        tmux source-file "$1"
        # Get new status right value.
        status_right_value="$(get_tmux_option "status-right" "")"
        # Add Continuum command.
        status_right_value="${continuum_command}${status_right_value}"
        # Check that the Continuum command is not already added.
        # if ! [[ "$status_right_value" == *continuum_save.sh* ]] ; then
        #     # Prepend Continuum command to the status line.
        #     new_status_right_value="${continuum_command}${status_right_value}"
        # fi
    fi

    # Add auto dark mode command.
    CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    local adm_command="#($CURRENT_DIR/auto-dark-mode.sh)"
    # Check that the command is not already added.
    if ! [[ "$status_right_value" == *"$adm_command"* ]] ; then
        # Prepend the command to the status line.
        status_right_value="${adm_command}${status_right_value}"
    fi

    # Set status-right value.
    set_tmux_option "status-right" "$status_right_value"
}

change_iterm_color() {
    # Change iTerm color preset.
    osascript -e "tell app \"System Events\" to keystroke \"$1\" using {control down, shift down, option down, command down}"
}

set_dark_mode() {
    # Change status line to dark style.
    set_status_right_value "$(get_tmux_option "@adm-status-dark" "")"
    set_tmux_option "@adm-current-mode" "dark"
    # If option "adm-iterm" is set, change iTerm color preset.
    if [[ "$(get_tmux_option "@adm-iterm" "")" == "on" ]] ; then
        change_iterm_color "d"
    fi
}

set_light_mode() {
    # Change status line to light style.
    set_status_right_value "$(get_tmux_option "@adm-status-light" "")"
    set_tmux_option "@adm-current-mode" "light"
    # If option "adm-iterm" is set, change iTerm color preset.
    if [[ "$(get_tmux_option "@adm-iterm" "")" == "on" ]] ; then
        change_iterm_color "l"
    fi
}
