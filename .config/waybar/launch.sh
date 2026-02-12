#!/bin/bash

# pushing notification using swaync
notify-send "restarting waybar..."

# kill all waybar instances
killall waybar

# wait for half a second
sleep 0.5

# load the configuration based on the user
if [[ $USER == 'joe' ]]; then
    waybar -c ~/.config/waybar/minimal/config -s ~/.config/waybar/minimal/style.css &
else 
    waybar &
fi