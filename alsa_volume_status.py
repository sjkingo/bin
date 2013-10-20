#!/usr/bin/env python2.7

import re
import subprocess

def get_mixer_output(mixer='Master'):
    return subprocess.check_output('amixer sget %s | grep \'%%\'' % mixer, shell=True)

def parse_volume(output):
    # we assume the channels are locked so only care about the first line
    channel = output.split('\n')[0]
    off = re.search(r'\[off\]', channel)
    if not off:
        vol = int(re.search(r'\[(\d+)%\]', channel).groups()[0])
    else:
        vol = 0
    return vol


if __name__ == '__main__':
    print parse_volume(get_mixer_output())
