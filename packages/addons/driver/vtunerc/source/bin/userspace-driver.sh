#!/bin/sh

################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

. /etc/profile

ADDON_DIR="$HOME/.xbmc/addons/driver.dvb.vtunerc"
ADDON_HOME="$HOME/.xbmc/userdata/addon_data/driver.dvb.vtunerc"
ADDON_SETTINGS="$ADDON_HOME/settings.xml"

mkdir -p $ADDON_HOME

if [ ! -f "$ADDON_SETTINGS" ]; then
  cp $ADDON_DIR/settings-default.xml $ADDON_SETTINGS
fi

mkdir -p /var/config
cat "$ADDON_SETTINGS" | awk -F\" '{print $2"=\""$4"\""}' | sed '/^=/d' > /var/config/vtunerc.conf

. /var/config/vtunerc.conf

if [ -z "$(pidof vtunerc)" ]; then
  # if not already added
  modprobe vtunerc

  vtunerc -v 0 -f $TUNER_TYPE >/dev/null 2>&1 &
fi
