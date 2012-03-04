#!/bin/sh
ADDON_DIR="$HOME/.xbmc/addons/emulator.mame"

mkdir -p "/storage/emulators/mame/roms"

export LD_LIBRARY_PATH=$ADDON_DIR/bin/

chmod a+rx "$ADDON_DIR/bin/mame" 
"$ADDON_DIR/bin/mame" -rompath /storage/emulators/mame/roms "$@" &

sleep 7
killall -STOP xbmc.bin

while [ $(pidof mame) ];do
    usleep 200000
done;
killall -CONT xbmc.bin
