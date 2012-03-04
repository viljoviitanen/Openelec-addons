#!/bin/sh
################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2012 Viljo Viitanen (viljo.viitanen@iki.fi)
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
#  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

die() {
  echo "$0: fatal error: $1"
  exit 1
}

# command line parameters are the addons to build this time
# default read from addons/$ARCH
PARAMS="$@"

# ARCH and PROJECT environment variables specify the archs and projects to build
if [ "x$ARCH" = "x" ]; then
  #default projects and archs that addons are built for if not specified via env
  TARGETS="Generic i386 Intel x86_64"
else
  [ "x$PROJECT" = "x" ] && die "specify both ARCH and PROJECT"
  TARGETS="$PROJECT $ARCH"
fi

CONF="$HOME/.openelec-addons"

MYDIR=`pwd`"/"`dirname "$0"`

which unzip >/dev/null || die "Need an unzip executable in path!"
which python >/dev/null || die "Need a python executable in path!"
[ ! -f "$MYDIR/addons_xml_generator.py" ] && die "Cannot find addons_xml_generator.py ??? I looked in $MYDIR"

if [ ! -f $CONF ]; then
  echo "Looks like this is the first time you're running this..."
  if [ -d "$HOME/OpenELEC.tv" ]; then
    echo "Found $HOME/OpenELEC.tv - going to assume this is your checked out openelec git tree."
    OPENELEC="$HOME/OpenELEC.tv"
  elif [ -d "$HOME/git/OpenELEC.tv" ]; then
    echo "Found $HOME/git/OpenELEC.tv - going to assume this is your checked out openelec git tree"
    OPENELEC="$HOME/git/OpenELEC.tv"
  else
    echo "Enter path to a checked out openelec git tree:"
    read OPENELEC
  fi
  echo "Writing configuration to $CONF"
  echo "#openelec-addons configuration file" > $CONF
  echo "OPENELEC=\"$OPENELEC\"" >> $CONF
else
  . ~/.openelec-addons
fi

[ "x$OPENELEC" = "x" ] && die "Missing OPENELEC setting in configuration file $CONF"

echo "Using openelec directory $OPENELEC"

echo "Copying addon packages"
cp -rp packages "$OPENELEC/" || die "copying packages"

doit() {
  cd "$OPENELEC" || die "cannot change directory to openelec dir $OPENELEC"
  PROJECT=$1
  ARCH=$2
  
  #if no command line parameters were given, build all
  if [ "x$PARAMS" = "x" ]; then
    ADDONS=`cd $MYDIR/addons/$ARCH && ls`
  else
    ADDONS=$PARAMS
  fi
  [ "x$ADDONS" = "x" ] && die "No addons to build?"

  for addon in $ADDONS; do
    echo "Project: $PROJECT Arch: $ARCH create_addon $addon"
    export PROJECT
    export ARCH
    scripts/create_addon $addon || die "create_addon failed"
  done
  #XXX here's a tricky part. If we have many versions in the target addon dir, get the newest version. Hope it's what we want!
  #XXX maybe add version to parameters in addition of project and arch?
  cd target/addons
  NUM=`ls | wc -l`
  VERSION=`ls -t | head -1`
  if [ $NUM -gt 1 ]; then
    echo " +++++++++++++ Careful! You have addons for many versions of openelec in your target dir" `pwd` " - picking $VERSION which has most recent timestamp"
  fi
  cd $VERSION/$PROJECT/$ARCH || die "cannot change directory to $OPENELEC/target/addons/$VERSION/$PROJECT/$ARCH"
  #here we get just the plain directory names, like emulator.fceu
  for dir in `find . -maxdepth 1 -type d | egrep '^[.]/' | sed 's/^[.]\///'`; do
    unzip -o `ls -t $dir/$dir*zip | head -1` $dir/addon.xml
  done
  python "$MYDIR/addons_xml_generator.py"
  #recursively do the rest of the targets...
  if [ "x$3" != "x" ]; then
    shift
    shift
    doit "$@"
  fi 
}

doit $TARGETS
