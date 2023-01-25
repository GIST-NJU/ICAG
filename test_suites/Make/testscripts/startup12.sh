TDIR=$(mktemp -d)
cd $TDIR

printf "# Demonstrate GNU make-3.82 parsing error\n\nutil.a: foo.c bar.c util.a(foo.o bar.o)\n\nfoo.c:\n	echo '#include <stdio.h>' >\$@\n	echo 'void foo(void) {}' >>\$@\n\nbar.c:\n	echo '#include <stdio.h>' >\$@\n	echo 'void bar(void) {}' >>\$@" > Makefile
