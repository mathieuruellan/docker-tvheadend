#/bin/bash
while true ; do
  /usr/bin/tvheadend -C -c /config >/dev/null 2>&1
  sleep 10
done
