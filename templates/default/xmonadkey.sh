#!/bin/sh
# by Patrick Wyatt
# /etc/init.d/xmonadkey.sh
#
# What is this for?
#
# It remaps XF86Copy key (not found on standard keyboards) to the left Windows key. This enables the left Windows key to be used for XMonad inside a virtual machine without Winblows stealing the key input.
#
# On the Windows machine hosting the virtual machine it is necessary to remap the left Windows key to F15, which is unused on modern computers.
#

setkeycodes 66 133

