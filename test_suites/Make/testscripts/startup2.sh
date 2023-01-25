temp=$(mktemp -d)
cd $temp
touch a.one
touch a.two
touch a.three

cat << EOF > Makefile
.PHONY: all
all: a.four
%.four : %.t* ; @echo \$@: \$(sort \$^)
EOF
