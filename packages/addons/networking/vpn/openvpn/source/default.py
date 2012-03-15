################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2012 Viljo Viitanen (viljo.viitanen@iki.fi) 
#      Copyright (C) 2009-2011 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2011-2011 Gregor Fuis (gujs@openelec.tv)
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

import os
import sys
import re
import xbmcaddon
import datetime

now = datetime.datetime.now()

__settings__   = xbmcaddon.Addon(id='network.vpn.openvpn')
__cwd__        = __settings__.getAddonInfo('path')
__path__       = xbmc.translatePath( os.path.join( __cwd__, 'bin', "openvpn") )

filename   = __settings__.getSetting('filename')
username   = __settings__.getSetting('username')
password   = __settings__.getSetting('password')

if filename == '':
  __settings__.openSettings(url=sys.argv[0])
  
cdir = re.sub(r'[^/]+$','',filename)

os.system( "chmod a+rx " + __path__ )
os.system( "mkdir -p /storage/logfiles/" )
os.system( "echo '%s' > /tmp/openvpn.credentials" % (username.replace("'", "'\\''")) )
os.system( "echo '%s' >> /tmp/openvpn.credentials" % (password.replace("'", "'\\''")) )

os.system( "%s --cd '%s' --config '%s' --auth-user-pass /tmp/openvpn.credentials >> /storage/logfiles/openvpn.%s.log" % (__path__,cdir.replace("'", "'\\''"), filename.replace("'", "'\\''"), now.strftime("%Y-%m-%d")) )

