# Generated automatically from Makefile.in by configure.
# src/Makefile - library main Makefile
# 
#  This file is
#    Copyright (C) 1997-1999 Ian Jackson <ian@davenant.greenend.org.uk>
#
#  It is part of adns, which is
#    Copyright (C) 1997-2000 Ian Jackson <ian@davenant.greenend.org.uk>
#    Copyright (C) 1999-2000 Tony Finch <dot@dotat.at>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software Foundation,
#  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. 

srcdir=		.

TARGETS=	libadns.a
include		$(srcdir)/../settings.make
include		adns.make

install:
		set -xe; for f in $(TARGETS); \
			do $(INSTALL_DATA) $$f $(lib_dir)/$$f; done
		$(INSTALL_DATA) $(srcdir)/../src/adns.h $(include_dir)/adns.h

uninstall:
		for f in $(TARGETS); do rm -f $(lib_dir)/$$f; done
		rm -f $(include_dir)/adns.h

ALLOBJS=	$(LIBOBJS)

libadns.a:	$(LIBOBJS)
		rm -f $@
		$(AR) cqv $@.new $(LIBOBJS)
		$(RANLIB) $@.new
		mv -f $@.new $@

$(LIBOBJS):	adns.h internal.h config.h
