#!/usr/bin/python

import urllib2
import sys

from pywkhtmltopdf import HTMLToPDFConverter

def main():
    fp = urllib2.urlopen('http://sjkingston.com/_cv/full.html')
    c = HTMLToPDFConverter()
    o = c.convert(fp.read())

    output_filename = 'cv.pdf'
    with open(output_filename, 'wb') as fp:
        fp.write(o)
    print('Wrote %d bytes to %s' % (len(o), output_filename))


if __name__ == '__main__':
    main()
