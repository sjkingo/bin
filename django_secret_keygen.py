#!/usr/bin/env python3

"""
Print a securely-generated random secret key suitable for using in
settings.SECRET_KEY. This code was taken from Django 2.1.
"""

import random

def get_random_secret_key():
    length = 50
    chars = 'abcdefghijklmnopqrstuvwxyz0123456789@$^*-_+'
    rng = random.SystemRandom()
    return ''.join(rng.choice(chars) for i in range(length))

print(get_random_secret_key())
