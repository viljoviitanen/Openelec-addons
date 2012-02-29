#!/bin/sh
ADDON_DIR="$HOME/.xbmc/addons/emulators.ssnes"
ADDON_HOME="$HOME/.xbmc/userdata/addon_data/emulators.ssnes"

mkdir -p "$ADDON_HOME"

export LD_LIBRARY_PATH=$ADDON_DIR/bin/

chmod a+rx "$ADDON_DIR/bin/ssnes" 
"$ADDON_DIR/bin/ssnes" -S "$ADDON_HOME" -c "$ADDON_HOME/ssnes.cfg" -s "$ADDON_HOME" "$@" &

if [ ! -f "$ADDON_HOME/ssnes.cfg" ]
then
        cp -P $ADDON_DIR/config/* $ADDON_HOME/ -r
fi
        

sleep 2
killall -STOP xbmc.bin

while [ $(pidof ssnes) ];do
    usleep 200000
done;
killall -CONT xbmc.bin
