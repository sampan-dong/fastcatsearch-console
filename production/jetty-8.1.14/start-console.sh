#!/bin/sh
cd `dirname $0`
SERVER_HOME=`pwd`

java -jar start.jar > $SERVER_HOME/logs/server.log 2>&1 &
