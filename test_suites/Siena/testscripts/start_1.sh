echo "starting up server 1(parent)..."
#
java siena.StartServer -port 7000 &
server1=$!
#
sleep 3
