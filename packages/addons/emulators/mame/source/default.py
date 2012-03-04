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
import xbmcgui
import xbmcaddon

__settings__   = xbmcaddon.Addon(id='emulator.mame')
__cwd__        = __settings__.getAddonInfo('path')
__param__        = __settings__.getSetting('param')
__path__       = xbmc.translatePath( os.path.join( __cwd__, 'bin', "mame.sh") )

os.system( "chmod a+rx " + __path__ )
os.system( "%s %s"%(__path__,__param__))

