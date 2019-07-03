#!/bin/bash
[ ! -f /usr/bin/curl ] && apk add --no-cache curl
function push()
{
z=$(ps aux)
a=$z
while read -r z
do
    var=$var$(awk '{print "cpu_usage{process=\""$11"\", pid=\""$2"\"}", $3z}');
done <<< "$z"

while read -r a
do
    var2=$var2$(awk '{print "memory_usage{process=\""$11"\", pid=\""$2"\"}", $4z}');
done <<< "$a"

curl -X POST -H  "Content-Type: text/plain" --data "$var
$var2
" http://localhost:9091/metrics/job/top/instance/`hostname`
[ $? -eq 0 ] && echo "`date` push ok"
unset var var2
}

while sleep 2; do push; done;
