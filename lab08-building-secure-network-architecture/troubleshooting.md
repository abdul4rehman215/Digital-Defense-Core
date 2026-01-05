# 🛠️ Troubleshooting – Lab 8: Building a Secure Network Architecture

---

## Issue 1: Virtual Interfaces Not Created

**Problem:**  
Virtual network interfaces fail to create.

**Solution:**

### Check if dummy module is loaded
```
sudo modprobe dummy
```

### Verify module is loaded
```
lsmod | grep dummy
```
### If still failing, try with different interface names
```
sudo ip link add name test0 type dummy
```

---

## Issue 2: iptables Rules Not Applying

**Problem:**
iptables rules don't seem to work.

**Solution:**

### Check if iptables service is running
```
sudo systemctl status iptables
```

### Verify rules are actually applied
```
sudo iptables -L -v -n --line-numbers
```

### Check for conflicting rules
```
sudo iptables -S
```

---

## Issue 3: IP Forwarding Not Working

**Problem:**
Traffic not forwarding between interfaces.

**Solution:**

### Verify IP forwarding is enabled
```
cat /proc/sys/net/ipv4/ip_forward
```

### Enable temporarily
```
sudo sysctl net.ipv4.ip_forward=1
```

### Check routing table
```
ip route show
```

---

## Issue 4: Log Files Not Showing Traffic

**Problem:**
No log entries for dropped packets.

**Solution:**

### Check if rsyslog is running
```
sudo systemctl status rsyslog
```

### Verify log configuration
```
sudo grep -i kern /etc/rsyslog.conf
```

### Check alternative log locations
```
sudo tail -f /var/log/messages | grep iptables
```

---

## Verification and Testing

## Final Verification Steps

### Check all interfaces are up
```
ip addr show | grep -E "(dmz0|internal0|mgmt0)"
```

### Verify iptables rules
```
sudo iptables -L -v -n
```

### Test network monitoring
```
sudo /usr/local/bin/network_monitor.sh
```
### Run validation script
```
sudo ~/validate_network.sh
```

---

## Performance Testing

### Monitor system resources
```
top -p $(pgrep iptables)
```
### Check network performance
```
cat /proc/net/dev
```
