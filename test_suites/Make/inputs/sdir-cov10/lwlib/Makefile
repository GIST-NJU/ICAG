# Generated automatically from Makefile.in by configure.
# This was taken from the output of Imake
# and set up to be configured by ../configure.
# Some parts Copyright (c) 1992, 1993 Lucid, Inc.

srcdir=/nfs/spectre/u6/ruthruff/research/subjects/make/inputs/sdir-cov10/lwlib
VPATH=/nfs/spectre/u6/ruthruff/research/subjects/make/inputs/sdir-cov10/lwlib
C_SWITCH_X_SITE=-I/usr/openwin/include

CC=gcc
CFLAGS= -g -O 
CPP=gcc -E
LN_S=ln -s
RANLIB=ranlib
# See below--LUCID is used below.
USE_X_TOOLKIT=LUCID

              TOP = .

               AR = ar cq

               LN = ln -s
               RM = rm -f

     LUCID_OBJS = lwlib-Xlw.o xlwmenu.o lwlib-Xaw.o
     MOTIF_OBJS = lwlib-Xm.o
      OLIT_OBJS = lwlib-Xol.o lwlib-Xolmb.o

TOOLKIT_DEFINES = -DUSE_$(USE_X_TOOLKIT)
   TOOLKIT_OBJS = $(LUCID_OBJS)

           OBJS = lwlib.o $(TOOLKIT_OBJS) lwlib-utils.o

# ../src is needed to find config.h.
ALL_CFLAGS= $(C_SWITCH_SITE) $(C_SWITCH_SYSTEM) $(C_SWITCH_X_SITE) \
  $(C_SWITCH_X_SYSTEM) $(C_SWITCH_MACHINE) $(CPPFLAGS) $(CFLAGS) \
  -DEMACS_BITMAP_FILES -DHAVE_CONFIG_H -Demacs \
  -I. -I../src -I${srcdir} -I${srcdir}/../src

.c.o:
	$(CC) -c ${ALL_CFLAGS} $<

all:: liblw.a

liblw.a: $(OBJS)
	$(RM) $@
	$(AR) $@ $(OBJS)
	@echo Do not be alarmed if the following ranlib command
	@echo fails due to the absence of a ranlib program on your system.
	-$(RANLIB) $@ || true
#If running ranlib fails, probably there is none.
#That's ok.  So don't stop the build.

# Depend on Makefile so that we recompile if TOOLKIT_DEFINES changes.
lwlib.o:  $(srcdir)/lwlib.c  Makefile
	$(CC) -c $(TOOLKIT_DEFINES) $(ALL_CFLAGS) $(srcdir)/lwlib.c

xrdb-cpp.o:  $(srcdir)/xrdb-cpp.c
	$(CC) -c "-DCPP_PROGRAM=$(CPP)" $(ALL_CFLAGS) $(srcdir)/xrdb-cpp.c

lwlib-utils.o: lwlib-utils.c lwlib-utils.h
lwlib.o:       lwlib.c lwlib.h lwlib-int.h
lwlib-Xlw.o:   lwlib-Xlw.c lwlib.h lwlib-int.h
lwlib-Xaw.o:   lwlib-Xaw.c lwlib.h lwlib-int.h
lwlib-Xm.o:    lwlib-Xm.c lwlib.h lwlib-int.h lwlib-utils.h
lwlib-Xol.o:   lwlib-Xol.c lwlib.h lwlib-int.h
lwlib-Xolmb.o: lwlib-Xolmb.c lwlib-Xolmb.h lwlib-XolmbP.h
xlwmenu.o: xlwmenu.c xlwmenu.h lwlib.h xlwmenuP.h

mostlyclean:
	$(RM) *.o core errs ,* *~ *.a .emacs_* make.log MakeOut \#*

clean: mostlyclean
distclean: clean
maintainer-clean: distclean

TAGS:
	../lib-src/etags -t *.[ch]
tags: TAGS
.PHONY: tags
