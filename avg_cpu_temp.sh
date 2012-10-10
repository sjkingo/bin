#!/bin/bash

# Print the average CPU temperature at the present time. This takes an
# average over all CPU cores.

SENSOR_NAME="coretemp-isa-0000"
sensors $SENSOR_NAME | grep Core | cut -d '+' -f 2 | cut -d '°' -f 1 | awk -e '{ tot += $field } END { printf("%.2f\n", tot/NR) }'
