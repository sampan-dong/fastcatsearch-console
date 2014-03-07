@echo off
IF NOT EXIST temp mkdir temp

echo fastcatsearch-console start. see logs/server.log file.

REM SET JAVA_PATH=C:\Program Files\Java\jdk1.6.0_29\bin\

"%JAVA_PATH%java.exe" -jar start.jar>>logs/server.log 2>&1
