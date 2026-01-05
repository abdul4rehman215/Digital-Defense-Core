# 🛠️ Troubleshooting – Lab 7: VPN Configuration and TLS

---

## Issue 1: OpenVPN Service Fails to Start

### Symptoms
- `openvpn-server@server` service is inactive or failed
- `systemctl status` shows errors

### Diagnosis
```bash
sudo systemctl status openvpn-server@server
sudo journalctl -u openvpn-server@server
````

### Common Causes

* Syntax error in `server.conf`
* Missing or incorrect certificate paths
* Incorrect permissions on key files

### Fix

```bash
sudo openvpn --config /etc/openvpn/server/server.conf --verb 9
sudo ls -la /etc/openvpn/server/
sudo chmod 600 /etc/openvpn/server/*.key
```

---

## Issue 2: Client Unable to Connect to VPN Server

### Symptoms

* Client hangs on `TLS Error: TLS key negotiation failed`
* VPN client process exits immediately

### Diagnosis

```bash
sudo netstat -ulnp | grep 1194
sudo ss -ulnp | grep 1194
```

### Common Causes

* Server not listening on port 1194
* Firewall blocking UDP traffic
* Incorrect server IP or port in client configuration

### Fix

```bash
sudo ufw status
sudo ufw allow 1194/udp
```

Verify client config:

```bash
cat ~/client-configs/client.ovpn
```

---

## Issue 3: VPN Tunnel Created but No Internet Access

### Symptoms

* `tun0` interface exists
* Cannot access external websites

### Diagnosis

```bash
cat /proc/sys/net/ipv4/ip_forward
sudo iptables -t nat -L -v
```

### Common Causes

* IP forwarding disabled
* Missing NAT masquerade rule
* DNS not pushed to client

### Fix

```bash
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o ens5 -j MASQUERADE
```

Ensure DNS push directives exist in `server.conf`.

---

## Issue 4: Certificates or Keys Not Found

### Symptoms

* OpenVPN reports `Cannot load certificate`
* TLS handshake fails

### Diagnosis

```bash
ls -la /etc/openvpn/server/
```

### Fix

Ensure the following files exist:

* `ca.crt`
* `vpn-server.crt`
* `vpn-server.key`
* `dh.pem`
* `ta.key`

Re-copy files if missing:

```bash
sudo cp ~/easy-rsa/pki/* /etc/openvpn/server/
```

---

## Issue 5: TLS Errors with curl

### Symptoms

* `SSL certificate problem`
* `TLS handshake failed`

### Diagnosis

```bash
curl --version | grep TLS
```

### Fix

```bash
sudo apt update
sudo apt install --reinstall ca-certificates
```

For testing only:

```bash
curl -k https://example.com
```

---

## Issue 6: Wireshark / tshark Cannot Capture Packets

### Symptoms

* Permission denied when capturing traffic
* No interfaces visible

### Diagnosis

```bash
tshark -D
groups
```

### Fix

```bash
sudo usermod -a -G wireshark $USER
newgrp wireshark
```

Always run capture commands with `sudo`.

---

## Issue 7: VPN Traffic Appears Unencrypted

### Symptoms

* Payload seems readable in capture

### Explanation

This usually indicates:

* Traffic captured on decrypted interface (`tun0`)
* Not on physical interface (`ens5`)

### Fix

Capture encrypted traffic on UDP port 1194:

```bash
sudo tshark -i any -f "port 1194"
```

---

## Issue 8: Client Configuration Inline Certificates Not Working

### Symptoms

* Client fails to authenticate
* Inline cert parsing errors

### Fix

Ensure correct order and tags in `client.ovpn`:

```text
<ca> ... </ca>
<cert> ... </cert>
<key> ... </key>
<tls-auth> ... </tls-auth>
```

Ensure no extra spaces or missing tags.

---

## Issue 9: VPN Disconnects Frequently

### Causes

* Network instability
* Aggressive firewall rules
* Keepalive mismatch

### Fix

Verify keepalive settings:

```conf
keepalive 10 120
```

Check logs:

```bash
tail -f /var/log/openvpn/openvpn-status.log
tail -f /tmp/vpn-client.log
```

---

## Issue 10: Cleanup Leaves Stale Interfaces

### Symptoms

* `tun0` still visible after stopping VPN

### Fix

```bash
sudo pkill -f openvpn
sleep 3
ip addr show | grep tun || echo "Tunnel removed"
```

---

## ✅ Best Practices

* Always verify certificates before deployment
* Rotate keys periodically
* Restrict VPN access via firewall rules
* Log and monitor VPN connections
* Test TLS versions and cipher suites regularly

---
