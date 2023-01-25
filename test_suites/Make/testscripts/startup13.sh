TDIR=$(mktemp -d)
cd $TDIR

printf "include bar(x).make" > foo.make
printf "foo(x)/tada: \n\t@echo tada" > "bar(x).make"
