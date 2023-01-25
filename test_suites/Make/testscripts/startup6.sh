fail=0
rm -rf tmp
mkdir tmp
cd tmp
touch foo.in

cat << EOF > Makefile
all: foo.c foo.o

clean:
	rm -f *.o *.h *.c

%.h %.c: %.in
	cp \$< \$*.h
	cp \$< \$*.c

%.o: %.c %.h
	echo \$+ >\$@
EOF