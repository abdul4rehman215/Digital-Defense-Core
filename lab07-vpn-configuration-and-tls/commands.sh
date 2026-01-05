#!/bin/bash
# 🧪 Lab 7: VPN Configuration and TLS
# Commands executed during the lab (verbatim, ordered)

############################################
# Task 1: Install OpenVPN and Easy-RSA
############################################

sudo apt update

sudo apt install -y openvpn easy-rsa

openvpn --version

############################################
# Task 1.2: Set up Certificate Authority
############################################

mkdir ~/easy-rsa
cd ~/easy-rsa

cp -r /usr/share/easy-rsa/* .

./easyrsa init-pki

./easyrsa build-ca nopass

############################################
# Task 1.3: Generate Server Certificate and Keys
############################################

./easyrsa gen-req vpn-server nopass

./easyrsa sign-req server vpn-server

./easyrsa gen-dh

openvpn --genkey secret pki/ta.key

############################################
# Task 1.4: Generate Client Certificate
############################################

./easyrsa gen-req vpn-client nopass

./easyrsa sign-req client vpn-client

############################################
# Task 1.5: Copy Certificates to OpenVPN Directory
############################################

sudo mkdir -p /etc/openvpn/server

sudo cp pki/ca.crt /etc/openvpn/server/
sudo cp pki/issued/vpn-server.crt /etc/openvpn/server/
sudo cp pki/private/vpn-server.key /etc/openvpn/server/
sudo cp pki/dh.pem /etc/openvpn/server/
sudo cp pki/ta.key /etc/openvpn/server/

mkdir ~/client-configs

cp pki/ca.crt ~/client-configs/
cp pki/issued/vpn-client.crt ~/client-configs/
cp pki/private/vpn-client.key ~/client-configs/
cp pki/ta.key ~/client-configs/

############################################
# Task 1.6: Create OpenVPN Server Configuration
############################################

sudo tee /etc/openvpn/server/server.conf > /dev/null << 'EOF'
port 1194
proto udp
dev tun
ca ca.crt
cert vpn-server.crt
key vpn-server.key
dh dh.pem
topology subnet
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist /var/log/openvpn/ipp.txt
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
compress lz4-v2
push "compress lz4-v2"
keepalive 10 120
tls-auth ta.key 0
cipher AES-256-GCM
auth SHA256
tls-version-min 1.2
max-clients 10
user nobody
group nogroup
persist-key
persist-tun
status /var/log/openvpn/openvpn-status.log
verb 3
mute 20
explicit-exit-notify 1
EOF

############################################
# Task 1.7: IP Forwarding and Firewall
############################################

echo 'net.ipv4.ip_forward=1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

sudo mkdir -p /var/log/openvpn

sudo ufw allow 1194/udp
sudo ufw allow OpenSSH

sudo iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o ens5 -j MASQUERADE
sudo iptables -A INPUT -i tun+ -j ACCEPT
sudo iptables -A FORWARD -i tun+ -j ACCEPT
sudo iptables -A FORWARD -i tun+ -o ens5 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i ens5 -o tun+ -m state --state RELATED,ESTABLISHED -j ACCEPT

sudo sh -c "iptables-save > /etc/iptables.rules"

sudo tee /etc/network/if-pre-up.d/iptables > /dev/null << 'EOF'
#!/bin/bash
/sbin/iptables-restore < /etc/iptables.rules
EOF

sudo chmod +x /etc/network/if-pre-up.d/iptables

############################################
# Task 1.8: Start and Enable OpenVPN Service
############################################

sudo systemctl start openvpn-server@server
sudo systemctl enable openvpn-server@server
sudo systemctl status openvpn-server@server

ip addr show tun0

############################################
# Task 1.9: Create Client Configuration
############################################

tee ~/client-configs/client.ovpn > /dev/null << 'EOF'
client
dev tun
proto udp
remote 127.0.0.1 1194
resolv-retry infinite
nobind
persist-key
persist-tun
compress lz4-v2
cipher AES-256-GCM
auth SHA256
tls-version-min 1.2
key-direction 1
verb 3
mute 20
EOF

echo '<ca>' >> ~/client-configs/client.ovpn
cat ~/client-configs/ca.crt >> ~/client-configs/client.ovpn
echo '</ca>' >> ~/client-configs/client.ovpn

echo '<cert>' >> ~/client-configs/client.ovpn
cat ~/client-configs/vpn-client.crt >> ~/client-configs/client.ovpn
echo '</cert>' >> ~/client-configs/client.ovpn

echo '<key>' >> ~/client-configs/client.ovpn
cat ~/client-configs/vpn-client.key >> ~/client-configs/client.ovpn
echo '</key>' >> ~/client-configs/client.ovpn

echo '<tls-auth>' >> ~/client-configs/client.ovpn
cat ~/client-configs/ta.key >> ~/client-configs/client.ovpn
echo '</tls-auth>' >> ~/client-configs/client.ovpn

############################################
# Task 2: Wireshark, VPN & TLS Testing
############################################

sudo DEBIAN_FRONTEND=noninteractive apt install -y wireshark tshark

sudo usermod -a -G wireshark $USER

sudo apt install -y curl wget netcat-openbsd tcpdump

sudo openvpn --config ~/client-configs/client.ovpn --daemon --log /tmp/vpn-client.log

sleep 10

ps aux | grep openvpn

ip addr show | grep -A 5 tun

ping -c 3 10.8.0.1

ip route | grep tun

sudo tshark -i tun0 -w /tmp/vpn_traffic.pcap &

ping -c 5 8.8.8.8

sudo pkill tshark

sudo tshark -r /tmp/vpn_traffic.pcap -V | head -20

curl -v https://www.google.com 2>&1 | head -20

curl -v --tlsv1.2 https://www.google.com 2>&1 | grep TLS
curl -v --tlsv1.3 https://www.google.com 2>&1 | grep TLS

sudo tshark -i any -f "port 443" -w /tmp/tls_traffic.pcap &

curl -s https://www.example.com > /dev/null
sleep 3
sudo pkill tshark

sudo tshark -r /tmp/tls_traffic.pcap -Y "tls.handshake.type"

############################################
# Cleanup
############################################

sudo pkill -f "openvpn.*client.ovpn"
ip addr show | grep tun || echo "VPN tunnel disconnected successfully"
ls -la /tmp/*.pcap
