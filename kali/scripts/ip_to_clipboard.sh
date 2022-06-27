#!/bin/bash

ip=$(ip a s $1 | awk -F"[ /]+" '/scope global/{print $3}')
echo -n "${ip}" | xclip -selection c
