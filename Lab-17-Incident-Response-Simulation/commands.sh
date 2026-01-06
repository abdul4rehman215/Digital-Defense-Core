#!/bin/bash

# -------------------------------
# Task 1: Environment Setup
# -------------------------------

sudo apt update
sudo apt install -y iptables net-tools iproute2 tcpdump nmap ufw

iptables --version
ss --version
tcpdump --version
nmap --version

mkdir -p ~/incident_lab
cd ~/incident_lab

cat > suspicious_server.py << 'EOF'
#!/usr/bin/env python3
import http.server
import socketserver
import time

class SuspiciousHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        print(f"Suspicious access from {self.client_address[0]} at {time.ctime()}")
        super().do_GET()

PORT = 8080
Handler = SuspiciousHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Suspicious server running on port {PORT}")
    httpd.serve_forever()
EOF

chmod +x suspicious_server.py
python3 suspicious_server.py &

echo "Suspicious server PID: $!" > server_pid.txt
cat server_pid.txt

# -------------------------------
# Baseline Collection
# -------------------------------

mkdir -p ~/incident_response
cd ~/incident_response

echo "=== INITIAL NETWORK ASSESSMENT ===" > initial_assessment.txt
echo "Date: $(date)" >> initial_assessment.txt
ss -tuln >> initial_assessment.txt
sudo iptables -L -n -v >> initial_assessment.txt
sudo netstat -tulpn >> initial_assessment.txt

cat initial_assessment.txt

# -------------------------------
# Task 2: Detection & Analysis
# -------------------------------

cd ~/incident_lab

cat > generate_suspicious_traffic.sh << 'EOF'
#!/bin/bash
nmap -sS localhost > /dev/null 2>&1 &
for i in {1..5}; do
 curl -s http://localhost:8080 > /dev/null &
 sleep 1
done

cat > fake_data.txt << DATAEOF
Confidential Company Data
Employee Records
Financial Information
DATAEOF

nc -l -p 9999 > /dev/null 2>&1 &
echo $! > nc_pid.txt
EOF

chmod +x generate_suspicious_traffic.sh
./generate_suspicious_traffic.sh
cat nc_pid.txt

cd ~/incident_response

echo "=== INCIDENT DETECTION ===" > incident_detection.txt
echo "Detection Time: $(date)" >> incident_detection.txt
ss -tuln | grep -E "(8080|9999)" >> incident_detection.txt
ps aux | grep -E "(python3|nc)" | grep -v grep >> incident_detection.txt

sudo tcpdump -i lo -c 20 -w suspicious_traffic.pcap port 8080 &
TCPDUMP_PID=$!
curl http://localhost:8080 > /dev/null
sleep 2
sudo kill $TCPDUMP_PID

echo "Network traffic captured" >> incident_detection.txt
cat incident_detection.txt

# -------------------------------
# Task 3: Containment
# -------------------------------

cat > containment_actions.sh << 'EOF'
#!/bin/bash
sudo iptables-save > iptables_backup.txt

sudo iptables -A INPUT -p tcp --dport 8080 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 8080 -j DROP

sudo iptables -A INPUT -p tcp --dport 9999 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 9999 -j DROP

sudo iptables -A INPUT -s 192.168.100.0/24 -j DROP
sudo iptables -A OUTPUT -d 192.168.100.0/24 -j DROP

sudo iptables -A INPUT -j LOG --log-prefix "INCIDENT_BLOCKED: "
sudo iptables -A OUTPUT -j LOG --log-prefix "INCIDENT_BLOCKED: "
EOF

chmod +x containment_actions.sh
./containment_actions.sh
sudo iptables -L -n -v

# -------------------------------
# Task 4: Network Segmentation
# -------------------------------

cat > network_segmentation.sh << 'EOF'
#!/bin/bash
sudo iptables -N QUARANTINE_ZONE
sudo iptables -A QUARANTINE_ZONE -p tcp --dport 22 -j ACCEPT
sudo iptables -A QUARANTINE_ZONE -p tcp --dport 53 -j ACCEPT
sudo iptables -A QUARANTINE_ZONE -p udp --dport 53 -j ACCEPT
sudo iptables -A QUARANTINE_ZONE -j DROP

sudo iptables -N SECURE_ZONE
sudo iptables -A SECURE_ZONE -p tcp --dport 80 -j ACCEPT
sudo iptables -A SECURE_ZONE -p tcp --dport 443 -j ACCEPT
sudo iptables -A SECURE_ZONE -p tcp --dport 22 -j ACCEPT
sudo iptables -A SECURE_ZONE -p tcp --dport 53 -j ACCEPT
sudo iptables -A SECURE_ZONE -p udp --dport 53 -j ACCEPT
sudo iptables -A SECURE_ZONE -j DROP

sudo iptables -A INPUT -s 127.0.0.1 -j SECURE_ZONE
EOF

chmod +x network_segmentation.sh
./network_segmentation.sh

# -------------------------------
# Task 5: Evidence Collection
# -------------------------------

cat > collect_evidence.sh << 'EOF'
#!/bin/bash
EVIDENCE_DIR="incident_evidence_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$EVIDENCE_DIR"

sudo cp /var/log/syslog "$EVIDENCE_DIR/" 2>/dev/null || true
sudo cp /var/log/auth.log "$EVIDENCE_DIR/" 2>/dev/null || true
cp *.txt *.pcap "$EVIDENCE_DIR/" 2>/dev/null || true

ps aux > "$EVIDENCE_DIR/system_state.txt"
ss -tuln >> "$EVIDENCE_DIR/system_state.txt"
sudo iptables -L -n -v >> "$EVIDENCE_DIR/system_state.txt"

echo "$EVIDENCE_DIR" > evidence_dir.txt
EOF

chmod +x collect_evidence.sh
./collect_evidence.sh

# -------------------------------
# Task 6: Cleanup & Verification
# -------------------------------

cat > cleanup_simulation.sh << 'EOF'
#!/bin/bash
pkill -f suspicious_server.py || true
pkill -f "nc.*9999" || true
EOF

chmod +x cleanup_simulation.sh
./cleanup_simulation.sh

cat > verify_containment.sh << 'EOF'
#!/bin/bash
timeout 3 curl http://localhost:8080
timeout 3 nc -zv localhost 9999
sudo iptables -L -n
ps aux | grep -E "(suspicious|nc)" | grep -v grep
EOF

chmod +x verify_containment.sh
./verify_containment.sh
