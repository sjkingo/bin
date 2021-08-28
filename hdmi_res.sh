#!/bin/bash

set -ex

# cvt 2560 1440 40
xrandr --newmode "2560x1440_40.00"  201.00  2560 2720 2984 3408  1440 1443 1448 1476 -hsync -vsync
MODE="$(xrandr | grep 2560x1440_40.00 | cut -d '(' -f 2 | cut -d ')' -f 1)"
xrandr --addmode HDMI-1 "$MODE"
xrandr --output HDMI-1 --mode "$MODE" --left-of LVDS-1
