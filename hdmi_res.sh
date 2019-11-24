#!/bin/bash
#xrandr --newmode "2560×1440" 220.812 2560 2608 2640 2720 1440 1443 1448 1478 -hsync -vsync
#xrandr --newmode $(cvt 2560 1440 | grep Modeline | cut -d ' ' -f 2-)

set -ex

# cvt 2560 1440 40
xrandr --newmode "2560x1440_40.00"  201.00  2560 2720 2984 3408  1440 1443 1448 1476 -hsync -vsync
#xrandr --newmode "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync -vsync
MODE="$(xrandr | grep 2560x1440_40.00 | cut -d '(' -f 2 | cut -d ')' -f 1)"
xrandr --addmode HDMI-2 "$MODE"
xrandr --output HDMI-2 --mode "$MODE"
