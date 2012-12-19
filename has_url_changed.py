#!/usr/bin/env python2.7

"""has_url_changed - report if the contents of a URL has changed since the last invocation.

Usage:
    python has_url_changed.py <url>

This will write a temporary file with the md5 hash of the contents. On repeated
invocations, it downloads the URL again and compares its hash with the old one.
No output is given if the website remains unchanged, otherwise writes output
that can be captured and emailed by cron.

Delete the temporary file to reset the script.
"""

import datetime
import hashlib
import os.path
import tempfile
import urllib2

LAST_HASH_FILE = os.path.join(tempfile.gettempdir(), 'has_website_changed.md5')

def last_hash_exists():
    return os.path.exists(LAST_HASH_FILE)

def compute_hash(data):
    h = hashlib.md5()
    h.update(data)
    return h.hexdigest()

def write_hash(h):
    with open(LAST_HASH_FILE, 'w') as fp:
        fp.write(h)
    print('Wrote hash to %s (delete this file to reset)' % LAST_HASH_FILE)

def get_last_hash():
    fp = open(LAST_HASH_FILE, 'r')
    h = fp.read()
    fp.close()
    return h

def check_url(url):
    ret = 0

    fp = urllib2.urlopen(url)
    data = fp.read()
    fp.close()
    new_hash = compute_hash(data)
    
    if not last_hash_exists():
        write_hash(new_hash)
    else:
        old_hash = get_last_hash()
        if new_hash != old_hash:
            last_run = datetime.datetime.fromtimestamp(os.path.getmtime(LAST_HASH_FILE))
            print('Contents of %s have changed since last run at %s' % (url, last_run.isoformat()))
            write_hash(new_hash)
            ret = 1

    return ret


if __name__ == '__main__':
    import sys
    assert len(sys.argv) == 2
    r = check_url(sys.argv[1])
    exit(r)
