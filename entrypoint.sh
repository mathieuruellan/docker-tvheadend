#/bin/bash
while true ; do
  /usr/bin/tvheadend -C -c /config > /dev/null
  sleep 10
done
