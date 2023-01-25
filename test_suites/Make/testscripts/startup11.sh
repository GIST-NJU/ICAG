TDIR=$(mktemp -d)
cd $TDIR

cat << EOF > Makefile
/tmp/foo.o:

/tmp/foo.y:
	@echo \$@

%.c: %.y
	touch \$@

%.o: %.c
	@echo \$@

.PHONY: install
install: /tmp/foo.c

EOF
