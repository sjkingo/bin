#!/bin/bash

photos="$1"

sleep 10
while true ; do
    awsetbg -r "$photos"
    sleep 10m
done
