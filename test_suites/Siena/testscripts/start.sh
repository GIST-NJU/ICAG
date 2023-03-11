echo "starting up server..."
#
java siena.StartServer -port 7000 &
server=$!
#
sleep 3
