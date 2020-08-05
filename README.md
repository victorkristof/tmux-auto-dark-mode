# tmux-auto-dark-mode

Automatically switch tmux to dark mode at night (for macOS).

## Features

- Automatically switch tmux (status line) to a dark styling when macOS enables Dark Mode
- Optionally switch iTerm2 to a dark color preset simultaneously
- Switch back to light status line at day time

## Installation

### [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add these lines to your `tmux.conf`:
```
set-option -g @plugin 'victorkristof/tmux-auto-dark-mode'
set-option -g @adm-dark-status '/path/to/dark-status.conf'
set-option -g @adm-light-status '/path/to/light-status.conf'
```

**Note for [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) users:** Make sure to add the above line **after** `set-option -g @plugin 'tmux-plugins/tmux-continuum'`.

Hit <kbd>prefix</kbd><kbd>I</kbd> to fetch the plugin and source it.
The plugin will automatically start in the background.
You can test it by turning on macOS Dark Mode (from System Preferences -> General -> Appearance -> Dark).
There might be a slight delay, as tmux-auto-dark-mode relies on tmux update interval which defaults to 15 seconds (check `tmux show-options -gqv "status-interval"`).

### Manual Installation

Clone the repo:
```
git clone git@github.com:victorkristof/tmux-auto-dark-mode.git ~/to/path
```

Add this line to your `tmux.conf`:
```
run-shell ~/to/path/dark-mode.tmux
set-option -g @adm-dark-status '/path/to/dark-status.conf'
set-option -g @adm-light-status '/path/to/light-status.conf'
```

Source your tmux config by running:
```
tmux source-file ~/.tmux.conf
```

The plugin will automatically start in the background.
You can test it by turning on macOS Dark Mode (from System Preferences -> General -> Appearance -> Dark).
There might be a slight delay, as tmux-auto-dark-mode relies on tmux update interval which defaults to 15 seconds (check `tmux show-options -gqv "status-interval"`).

## Automatically Switch iTerm2 Color Preset

Optionally, this plugin can switch iTerm2 to a dark or a light color preset.
I didn't find an easy way to do that, so it's a bit hacky for now.
(If you have a better idea, please open an issue or send a pull request!)
It requires *you* to do the following steps:

**1. Make sure that your profile has one dark color preset and one light color preset**

In Preferences -> Profiles -> [Choose profile you would like to use] -> Color Presets -> [Check that you have two different color presets for dark and light].

**2. Add two keyboard mappings to switch to the dark and the light presets**

In Preferences -> Profiles -> Keys -> [Select the same profile as in (1)] -> [Click the <kbd>+</kbd> button] -> [Select "Load color preset" as Action] -> [Add <kbd>Shift</kbd> <kbd>Control</kbd> <kbd>Command</kbd> <kbd>Option</kbd> <kbd>D</kbd> for the dark color preset, do the same with <kbd>L</kbd> for the light color preset]

It has to be exactly these mappings, as I have hard-coded them in the plugin.
I chose them in order to reduce the probability of conflict with general mappings.

**3. Add this line your your `tmux.conf`**

```
set-option -g @adm-iterm 'on'
```

## Requirements

- macOS Catalina (10.15)
- tmux 3.1 or above (not tested on earlier versions)
