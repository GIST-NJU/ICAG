# Generated automatically from Makefile.in by configure.
# regress/Makefile - regression test Makefile
# 
#  This file is
#    Copyright (C) 1997-2000 Ian Jackson <ian@davenant.greenend.org.uk>
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

PROGS_SYSDEP=	adnsresfilter

CLIENTS=	adnstest adnshost adnslogres $(PROGS_SYSDEP)
AUTOCHDRS=	harness.h hsyscalls.h hredirect.h
AUTOCSRCS=	hrecord.c hplayback.c hcommon.c
include		$(srcdir)/../settings.make
include		$(srcdir)/../src/adns.make

DIRCFLAGS=	-I$(srcdir)/../src

HCPPFLAGS=	-DADNS_REGRESS_TEST -I.

REDIRLIBOBJS=	$(addsuffix _d.o, $(basename $(LIBOBJS)))
HARNLOBJS=	hcommon.o $(REDIRLIBOBJS)
TARGETS=	$(addsuffix _record, $(CLIENTS)) $(addsuffix _playback, $(CLIENTS))
ADH_OBJS=	adh-main_c.o adh-opts_c.o adh-query_c.o
ALL_OBJS=	$(HARNLOBJS) dtest.o hrecord.o hplayback.o

.PRECIOUS:	$(AUTOCSRCS) $(AUTOCHDRS)

all install uninstall: $(TARGETS)

check:		$(TARGETS)
		./checkall

LINK_CMD=	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

%_record:	%_c.o hrecord.o $(HARNLOBJS)
		$(LINK_CMD)

%_playback:	%_c.o hplayback.o $(HARNLOBJS)
		$(LINK_CMD)

adnshost_%:	$(ADH_OBJS) h%.o $(HARNLOBJS)
		$(LINK_CMD)

%_d.o:		$(srcdir)/../src/%.c hredirect.h
		$(CC) $(CFLAGS) $(HCPPFLAGS) -c -g -o $@ $<

%_c.o:		$(srcdir)/../client/%.c hredirect.h
		$(CC) $(CFLAGS) $(HCPPFLAGS) -I $(srcdir)/../src -c -g -o $@ $<

$(ALL_OBJS):	$(srcdir)/../src/adns.h $(srcdir)/../src/internal.h
$(ALL_OBJS):	harness.h hsyscalls.h
$(ADH_OBJS):	$(srcdir)/../client/adnshost.h

%::	%.m4 hmacros.i4 hsyscalls.i4
	$(M4) -P $< >$@-a.new
	sed -e 's/hm_comma/,/g; s/hm_squote/'\''/g; /^[	 ]*$$/d' <$@-a.new >$@-b.new
	@mv -f $@-b.new $@; rm -f $@-a.new
