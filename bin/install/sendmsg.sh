#!/usr/bin/env bash
logs=/Users/noprom/Desktop/opt/event/*.event
for i in ${logs}; do
    echo $i;
    tail -n +0 -F $i &
done