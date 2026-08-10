#!/bin/sh
# Times the screen off and puts it to background
# swayidle \
#     timeout 10 'swaymsg "output * dpms off"' \
#     resume 'swaymsg "output * dpms on"' &
# Locks the screen immediately
# swaylock -f -c 550000
# Kills last background task so idle timer doesn't keep running
# kill %%

# Prevent multiple instances
pgrep -x hyprlock && exit 0

# Run hyprlock in the background so it doesn't block swayidle
hyprlock &
# Give it a moment to render before allowing the system to sleep
sleep 0.5
