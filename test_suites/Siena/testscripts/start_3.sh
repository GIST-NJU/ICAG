echo "starting up server 1(parent)..."
#
java siena.StartServer -port 7000 &
server1=$!
#
sleep 2
#
echo "starting up server 2(the child of server 1)..."
#
java siena.StartServer -port 3000 -master senp://:7000 &
server2=$!
#
sleep 5
