#!/bin/bash

HOST="0.0.0.0:10000"

set -e

source ~/.virtualenvs/sjkwi_billing/bin/activate
cd ~/sjkwi_billing
python manage.py runserver $HOST
