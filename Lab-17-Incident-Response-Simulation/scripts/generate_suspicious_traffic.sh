#!/bin/bash
echo "Generating suspicious network traffic..."

# Simulate port scanning activity
nmap -sS localhost > /dev/null 2>&1 &

# Generate repeated web requests
for i in {1..5}; do
  curl -s http://localhost:8080 > /dev/null &
  sleep 1
done

# Simulate fake sensitive data
cat > fake_data.txt << 'EOF'
Confidential Company Data
Employee Records: John Doe, Jane Smith
Financial Information: Q4 Revenue $1.2M
EOF

# Start suspicious listener
nc -l -p 9999 > /dev/null 2>&1 &
NC_PID=$!
echo $NC_PID > nc_pid.txt

echo "Suspicious traffic generated"
