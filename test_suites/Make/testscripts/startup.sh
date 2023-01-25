temp=$(mktemp -d)
cd $temp

cat << EOF > Makefile
all: ; @echo \$@
-include gen.mk
gen.mk: ; @echo > \$@
EOF
