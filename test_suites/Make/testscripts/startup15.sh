TDIR=$(mktemp -d)
cd $TDIR

cat << EOF > Makefile

all.foo.bar: %.foo.bar: %.one

all.foo.bar: %.bar: %.two

all.foo.bar:
	@echo $^

.DEFAULT:;@:
EOF
