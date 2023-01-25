temp=$(mktemp -d)
cd $temp

cat << EOF > Makefile
.SECONDEXPANSION:

%.so: | \$\$(extra) ; @echo \$^

foo.so: extra := foo.o
foo.so:
foo.o:
EOF