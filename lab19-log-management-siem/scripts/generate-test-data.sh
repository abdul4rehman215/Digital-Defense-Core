#!/bin/bash

echo "[+] Generating SIEM test events..."

for i in {1..6}; do
    ssh fakeuser@localhost 2>/dev/null
    sleep 1
done

sudo -k
sudo ls /root 2>/dev/null

curl http://localhost/?id=1 UNION SELECT 1,2,3 -- 2>/dev/null
curl http://localhost/../../etc/passwd 2>/dev/null
curl http://localhost/nonexistent-page 2>/dev/null

echo "[+] Test log events generated"
