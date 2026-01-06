# 🛠️ Troubleshooting – Lab 18

## Issue 1: Autopsy not starting
Check if port 9999 is already in use:
```
netstat -tlnp | grep 9999
```
```
pkill -f autopsy
```
```
autopsy &
```
## Issue 2: Loop device busy
Check active loop devices:
```
losetup -a
```
Detach unused device:
```
sudo losetup -d /dev/loopX
```
## Issue 3: Browser cannot connect
Verify service:
```
ps aux | grep autopsy
```
Check firewall:
```
sudo ufw status
```
