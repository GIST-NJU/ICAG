TDIR=$(mktemp -d)
cd $TDIR

cat << EOF > Makefile
TARGETS := foo foo.out

.PHONY: all foo.in

all: \$(TARGETS)

%: %.in
	@echo \$@

%.out: %
	@echo \$@

foo.in: ; @:

EOF
