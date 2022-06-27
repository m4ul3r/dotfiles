#!/bin/bash

# default kali background
nitrogen --set-auto /usr/share/backgrounds/kali/kali-layers-16x9.png
wmname compiz				# java fix
compton &				# transparent backgroun
~/.config/slstatus/slstatus &
/usr/bin/spice-vdagent &		# qemu/kvm
