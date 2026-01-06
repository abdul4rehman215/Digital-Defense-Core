#!/bin/bash
# ============================================================
# Lab 19: Log Management with SIEM Tools (ELK Stack)
# commands.sh
# ============================================================

echo "[+] Updating system and installing Java..."
sudo apt update && sudo apt upgrade -y
sudo apt install openjdk-11-jdk -y
java -version

# ============================================================
# Install Elasticsearch
# ============================================================

echo "[+] Installing Elasticsearch..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | \
sudo tee /etc/apt/sources.list.d/elastic7.x.list

sudo apt update
sudo apt install elasticsearch -y

echo "[+] Configuring Elasticsearch..."
sudo sed -i 's/#network.host: .*/network.host: localhost/' /etc/elasticsearch/elasticsearch.yml
sudo sed -i 's/#http.port: .*/http.port: 9200/' /etc/elasticsearch/elasticsearch.yml
echo "discovery.type: single-node" | sudo tee -a /etc/elasticsearch/elasticsearch.yml
echo "xpack.security.enabled: false" | sudo tee -a /etc/elasticsearch/elasticsearch.yml

sudo systemctl enable --now elasticsearch
sleep 30
curl http://localhost:9200/

# ============================================================
# Install Logstash
# ============================================================

echo "[+] Installing Logstash..."
sudo apt install logstash -y

echo "[+] Creating Logstash SIEM pipeline..."
sudo tee /etc/logstash/conf.d/siem-pipeline.conf > /dev/null << 'EOF'
input {
 file {
  path => "/var/log/auth.log"
  start_position => "beginning"
  type => "auth"
 }
 file {
  path => "/var/log/apache2/access.log"
  start_position => "beginning"
  type => "apache"
 }
}

filter {
 if [type] == "auth" {
  grok {
   match => {
    "message" => "%{SYSLOGTIMESTAMP:timestamp} %{HOSTNAME:host} %{PROG:program}(?:\[%{POSINT}\])?: %{GREEDYDATA:msg}"
   }
  }
  date {
   match => ["timestamp", "MMM  d HH:mm:ss", "MMM dd HH:mm:ss"]
  }
 }

 if [type] == "apache" {
  grok {
   match => {
    "message" => "%{COMBINEDAPACHELOG}"
   }
  }
 }
}

output {
 elasticsearch {
  hosts => ["localhost:9200"]
  index => "siem-logs-%{+YYYY.MM.dd}"
 }
}
EOF

sudo systemctl enable --now logstash

# ============================================================
# Install Kibana
# ============================================================

echo "[+] Installing Kibana..."
sudo apt install kibana -y

echo "[+] Configuring Kibana..."
sudo sed -i 's/#server.port:.*/server.port: 5601/' /etc/kibana/kibana.yml
sudo sed -i 's/#server.host:.*/server.host: "localhost"/' /etc/kibana/kibana.yml
sudo sed -i 's|#elasticsearch.hosts:.*|elasticsearch.hosts: ["http://localhost:9200"]|' /etc/kibana/kibana.yml

sudo systemctl enable --now kibana
sleep 60
curl -I http://localhost:5601

# ============================================================
# Install Apache (Log Source)
# ============================================================

echo "[+] Installing Apache..."
sudo apt install apache2 -y
sudo systemctl start apache2

curl http://localhost/
curl http://localhost/test-page

# ============================================================
# Create SIEM Scripts Directory
# ============================================================

echo "[+] Creating SIEM scripts directory..."
mkdir -p ~/siem-scripts
cd ~/siem-scripts

# ============================================================
# Authentication Log Analyzer Script
# ============================================================

cat > auth-analyzer.sh << 'EOF'
#!/bin/bash
LOG="/var/log/auth.log"
OUT="$HOME/siem-analysis"
DATE=$(date +%F_%H%M%S)
mkdir -p "$OUT"

grep "Failed password" "$LOG" | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr \
 > "$OUT/failed_logins_$DATE.txt"

grep "Failed password" "$LOG" | awk '{print $(NF-3)}' | sort | uniq -c | awk '$1>5' \
 > "$OUT/bruteforce_$DATE.txt"

grep "sudo:" "$LOG" > "$OUT/sudo_usage_$DATE.txt"

echo "Auth analysis complete → $OUT"
EOF

chmod +x auth-analyzer.sh
./auth-analyzer.sh

# ============================================================
# Web Log Analyzer Script
# ============================================================

cat > web-analyzer.sh << 'EOF'
#!/bin/bash
LOG="/var/log/apache2/access.log"
OUT="$HOME/siem-analysis"
DATE=$(date +%F_%H%M%S)
mkdir -p "$OUT"

awk '{print $1}' "$LOG" | sort | uniq -c | sort -nr | head -20 \
 > "$OUT/top_ips_$DATE.txt"

awk '{print $9}' "$LOG" | sort | uniq -c | sort -nr \
 > "$OUT/status_codes_$DATE.txt"

grep -Ei "union|select|../|<script>" "$LOG" \
 > "$OUT/web_attacks_$DATE.txt"

echo "Web analysis complete"
EOF

chmod +x web-analyzer.sh
./web-analyzer.sh

# ============================================================
# Real-Time Monitoring Script
# ============================================================

cat > realtime-monitor.sh << 'EOF'
#!/bin/bash
AUTH="/var/log/auth.log"
WEB="/var/log/apache2/access.log"
OUT="$HOME/siem-analysis"
mkdir -p "$OUT"

send_alert() {
 echo "[$(date)] $1" | tee -a "$OUT/alerts.log"
}

tail -F "$AUTH" | while read line; do
 echo "$line" | grep -q "Failed password" && send_alert "AUTH FAIL: $line"
 echo "$line" | grep -q "sudo:" && send_alert "SUDO: $line"
done &

tail -F "$WEB" | while read line; do
 echo "$line" | grep -Eq "404|union|select" && send_alert "WEB ALERT: $line"
done &

wait
EOF

chmod +x realtime-monitor.sh

# ============================================================
# Log Normalization Script
# ============================================================

cat > log-normalizer.sh << 'EOF'
#!/bin/bash
OUT="$HOME/siem-analysis/normalized"
mkdir -p "$OUT"

grep "Failed password" /var/log/auth.log | while read l; do
 echo "{\"event\":\"auth_failure\",\"raw\":\"$l\"}" >> "$OUT/auth.json"
done

awk '{print "{\"ip\":\""$1"\",\"status\":\""$9"\"}"}' \
/var/log/apache2/access.log >> "$OUT/web.json"

echo "Normalization complete"
EOF

chmod +x log-normalizer.sh
./log-normalizer.sh

# ============================================================
# Test Data Generator
# ============================================================

cat > generate-test-data.sh << 'EOF'
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
EOF

chmod +x generate-test-data.sh
./generate-test-data.sh

echo "[✓] Lab 19 commands execution complete"
