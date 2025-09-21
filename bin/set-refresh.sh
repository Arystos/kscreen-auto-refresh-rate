#!/bin/bash
OUTPUT="eDP-1" # Output name (you can find it using `kscreen-doctor -o`)
MODE_AC="1"    # ID for mode when on AC power
MODE_BAT="2"   # ID for mode when on battery power

STATE=$(cat /sys/class/power_supply/ADP0/online)
if [ "$STATE" = "1" ]; then
    kscreen-doctor output.$OUTPUT.mode.$MODE_AC
else
    kscreen-doctor output.$OUTPUT.mode.$MODE_BAT
fi
