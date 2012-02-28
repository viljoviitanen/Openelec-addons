#!/bin/sh
ADDON_DIR="$HOME/.xbmc/addons/emulators.mupen64plus"
ADDON_HOME="$HOME/.xbmc/userdata/addon_data/emulators.mupen64plus"

mkdir -p $ADDON_HOME
mkdir -p $ADDON_HOME/screenshots
mkdir -p $ADDON_HOME/savestates

if [ ! -f "$ADDON_HOME/mupen64plus.cfg" ] 
then
	cp -P $ADDON_DIR/data/* $ADDON_HOME/ -r
fi

export LD_LIBRARY_PATH=$ADDON_DIR/bin/
cd $ADDON_DIR/bin
./mupen64plus --configdir "$ADDON_HOME" --resolution 1920x1080 --fullscreen "$@" &


sleep 7
killall -STOP xbmc.bin

while [ $(pidof mupen64plus) ];do
    usleep 200000
done;
killall -CONT xbmc.bin
