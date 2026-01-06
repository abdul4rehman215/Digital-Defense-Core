# 🛠️ Troubleshooting – Lab 17: Incident Response Simulation

## Issue 1: Firewall Rules Not Working
If firewall rules do not appear to block traffic correctly:

# Check if iptables service is running
```
sudo systemctl status iptables 2>/dev/null || echo "iptables service not found (normal for some distributions)"
```

# Verify current firewall rules
```
sudo iptables -L -n
```

# Reload firewall rules if missing
```
sudo iptables-restore < iptables_backup.txt
````

---

## Issue 2: Suspicious Processes Will Not Terminate
If simulated malicious processes do not stop gracefully:

# Force terminate suspicious processes
```
sudo pkill -9 -f "suspicious_server.py"
sudo pkill -9 -f "nc.*9999"
```

# Verify no processes remain
```
ps aux | grep -E "(python.*suspicious|nc.*9999)" | grep -v grep
```

---

## Issue 3: Network Connectivity Issues After Containment
If legitimate services are affected after containment:

# Review active firewall rules
```
sudo iptables -L -n -v
```

# Remove specific blocking rules if required
```
sudo iptables -D INPUT -p tcp --dport 8080 -j DROP
sudo iptables -D OUTPUT -p tcp --dport 8080 -j DROP
```
# Test local connectivity
```
ping -c 3 localhost
```

---

## Issue 4: Packet Capture File Missing
If the packet capture file is not created:

# Ensure tcpdump is installed
```
tcpdump --version
```
# Re-run packet capture with correct permissions
```
sudo tcpdump -i lo -c 20 -w suspicious_traffic.pcap port 8080
```

---

## Issue 5: Evidence Files Missing
If evidence files were not collected correctly:

# Verify evidence directory exists
```
ls -ld incident_evidence_*
```

# Re-run evidence collection
```
./collect_evidence.sh
```

---

## Best Practice Reminder

* Do **NOT** delete suspicious processes before evidence collection
* Always **backup firewall rules** before making changes
* Maintain a **clear timeline** of response actions
* Preserve logs and packet captures for forensic review
* Containment is not eradication — cleanup comes later
