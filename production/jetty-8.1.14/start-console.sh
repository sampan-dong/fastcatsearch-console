#!/bin/sh
cd `dirname $0`
SERVER_HOME=`pwd`

if [ ! -d "temp" ]; then
	mkdir temp
fi

java -Dfile.encoding=UTF-8 -jar $SERVER_HOME/start.jar > $SERVER_HOME/logs/server.log 2>&1 &

echo fastcatsearch-console start. see logs/server.log file.
