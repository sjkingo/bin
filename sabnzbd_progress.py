#!/usr/bin/env python2.7

from __future__ import print_function
import json
import urllib2

# The URL to SABnzbd's API
BASE_URL = 'http://localhost:8080/api'

# API key for SABnzbd - found in Config -> General
API_KEY = 'eb2154ccf028e0ac19927c15a7e7969d'

def pprint(obj):
    print(json.dumps(obj, indent=4))

def construct_req_url(mode, output='json'):
    return '%s?mode=%s&output=%s&apikey=%s' % (BASE_URL, mode, output, API_KEY)

def fetch_queue_as_json():
    req_url = construct_req_url('queue')
    fp = urllib2.urlopen(req_url)
    d = fp.read()
    fp.close()
    return json.loads(d).get('queue')

def print_downloads():
    q = fetch_queue_as_json()
    d = q.get('slots')
    for n, i in enumerate(d):
        print('%s (%s) - ' % (i.get('filename'), i.get('size')), end='')

        if i.get('status') == 'Downloading':
            print('%s remaining at %s/s' % (i.get('timeleft'), q.get('speed')))
            status = '>'
        else:
            print(i.get('status'))
            status = ' '

        perc = int(i.get('percentage'))
        bar_filled = '=' * perc
        bar_unfilled = ' ' * (100-perc-1)
        if bar_unfilled < 0:
            bar_unfilled = 0
        print('  % 3d%% [%s%s%s] %s remaining' % (perc, bar_filled, status, bar_unfilled, i.get('sizeleft')))

        if n+1 <= len(d):
            print()


if __name__ == '__main__':
    print_downloads()
