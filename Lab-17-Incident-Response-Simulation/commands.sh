#!/bin/bash

# Task 1: Environment Setup & Initial Assessment
sudo apt update
sudo apt install -y iptables net-tools iproute2 tcpdump nmap ufw

iptables --version
ss --version
tcpdump --version
nmap --version

mkdir -p ~/incident_lab
cd ~/incident_lab

chmod +x suspicious_server.py
python3 suspicious_server.py &

SUSPICIOUS_PID=$!
echo "Suspicious server PID: $SUSPICIOUS_PID" > server_pid.txt
cat server_pid.txt

mkdir -p ~/incident_response
cd ~/incident_response

echo "=== INITIAL NETWORK ASSESSMENT ===" > initial_assessment.txt
echo "Date: $(date)" >> initial_assessment.txt
ss -tuln >> initial_assessment.txt
sudo iptables -L -n -v >> initial_assessment.txt
sudo netstat -tulpn >> initial_assessment.txt
cat initial_assessment.txt

# Task 2: Incident Detection & Analysis
cd ~/incident_lab
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
sleep 2
curl http://localhost:8080 > /dev/null 2>&1
sudo kill $TCPDUMP_PID

ls -lh suspicious_traffic.pcap
cat incident_detection.txt

# Task 3: Containment
chmod +x containment_actions.sh
./containment_actions.sh

sudo iptables -L -n -v

echo "=== CONTAINMENT VERIFICATION ===" > containment_verification.txt
timeout 5 curl http://localhost:8080 2>&1 >> containment_verification.txt
sudo iptables -L -n -v >> containment_verification.txt
ps aux | grep -E "(python3.*suspicious|nc.*9999)" | grep -v grep >> containment_verification.txt
cat containment_verification.txt

ls -lh iptables_backup.txt

# Task 4: Network Segmentation
chmod +x network_segmentation.sh
./network_segmentation.sh

echo "=== NETWORK SEGMENTATION DOCUMENTATION ===" > segmentation_config.txt
sudo iptables -L QUARANTINE_ZONE -n -v >> segmentation_config.txt
sudo iptables -L SECURE_ZONE -n -v >> segmentation_config.txt
cat segmentation_config.txt

# Task 5: Evidence Collection & Reporting
chmod +x collect_evidence.sh
./collect_evidence.sh

cat evidence_dir.txt
ls "$(cat evidence_dir.txt)"

# Task 6: Cleanup & Verification
chmod +x cleanup_simulation.sh
./cleanup_simulation.sh

echo "=== FINAL SYSTEM STATE ===" > final_system_state.txt
ss -tuln >> final_system_state.txt
sudo iptables -L -n -v >> final_system_state.txt
ps aux | grep -E "(python|nc|iptables)" | grep -v grep >> final_system_state.txt
cat final_system_state.txt

chmod +x verify_containment.sh
./verify_containment.sh
