#!/bin/bash
# ==========================================================
# Lab 15: Container Security Essentials
# Complete command execution log
# System: Ubuntu 20.04+ LTS
# Runtime: Docker Engine
# User: cloud-lab-user
# ==========================================================

########################################
# Task 1: Docker Image Vulnerability Scanning
########################################

# System update
sudo apt update && sudo apt upgrade -y

# Install prerequisites
sudo apt-get install wget apt-transport-https gnupg lsb-release -y

# Add Trivy repository key
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -

# Add Trivy repository
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" \
 | sudo tee -a /etc/apt/sources.list.d/trivy.list

# Update package list
sudo apt-get update

# Install Trivy
sudo apt-get install trivy -y

# Verify Trivy installation
trivy version

########################################
# Pull Docker images for scanning
########################################

docker pull nginx:1.18
docker pull node:14-alpine
docker pull python:3.8-slim

########################################
# Scan Docker images
########################################

# Full scan
trivy image nginx:1.18

# High and critical vulnerabilities only
trivy image --severity HIGH,CRITICAL nginx:1.18

# JSON output for automation
trivy image --format json --output nginx-scan-results.json nginx:1.18

# Analyze JSON output
cat nginx-scan-results.json | jq '.Results[0].Vulnerabilities | length'

# Scan Node image
trivy image --severity HIGH,CRITICAL node:14-alpine

# Table comparison
trivy image --format table --output scan-comparison.txt node:14-alpine
cat scan-comparison.txt

# OS-only vulnerabilities
trivy image --vuln-type os python:3.8-slim

########################################
# CI/CD style image scanning script
########################################

chmod +x scripts/container-security-scan.sh
./scripts/container-security-scan.sh nginx:1.18

########################################
# Task 2: Docker Security Features
########################################

# Check user namespace status
docker info | grep -i "user namespace"

# Stop Docker daemon
sudo systemctl stop docker

# Configure Docker daemon
sudo mkdir -p /etc/docker
sudo cp /tmp/daemon.json /etc/docker/daemon.json

# Configure user namespace mappings
sudo useradd -r -s /bin/false dockremap || true
echo 'dockremap:165536:65536' | sudo tee -a /etc/subuid
echo 'dockremap:165536:65536' | sudo tee -a /etc/subgid

# Restart Docker
sudo systemctl start docker
sudo systemctl status docker

# Verify user namespace enabled
docker info | grep -i "user namespace"

########################################
# Runtime security controls
########################################

docker run -d --name secure-nginx \
 --user 1000:1000 \
 --cap-drop ALL \
 --cap-add NET_BIND_SERVICE \
 --read-only \
 --tmpfs /tmp \
 --tmpfs /var/cache/nginx \
 --tmpfs /var/run \
 -p 8080:80 \
 nginx:alpine

docker exec secure-nginx whoami
docker exec secure-nginx id
docker exec secure-nginx touch /test-file

########################################
# AppArmor profile enforcement
########################################

sudo mkdir -p /etc/apparmor.d/containers
sudo cp /tmp/docker-nginx /etc/apparmor.d/containers/
sudo apparmor_parser -r -W /etc/apparmor.d/containers/docker-nginx

docker run -d --name apparmor-nginx \
 --security-opt apparmor=docker-nginx \
 -p 8081:80 \
 nginx:alpine

########################################
# Resource constraints
########################################

docker run -d --name resource-limited \
 --memory=128m \
 --memory-swap=128m \
 --cpus="0.5" \
 --pids-limit=100 \
 --ulimit nofile=1024:1024 \
 --restart=unless-stopped \
 nginx:alpine

docker stats resource-limited --no-stream
docker exec resource-limited sh -c 'dd if=/dev/zero of=/tmp/test bs=1M count=200'

########################################
# Network isolation
########################################

docker network create --driver bridge \
 --subnet=172.20.0.0/16 \
 --ip-range=172.20.240.0/20 \
 --gateway=172.20.0.1 \
 secure-network

docker run -d --name web-server \
 --network secure-network \
 --ip 172.20.240.10 \
 nginx:alpine

docker run -d --name app-server \
 --network secure-network \
 --ip 172.20.240.11 \
 python:3.8-alpine sleep 3600

docker exec web-server ping -c 3 172.20.240.11
docker exec app-server ping -c 3 172.20.240.10
docker exec web-server ping -c 3 8.8.8.8

########################################
# Task 3: Monitoring & Compliance
########################################

# Install Falco
curl -s https://falco.org/repo/falcosecurity-3672BA8F.asc | sudo apt-key add -
echo "deb https://download.falco.org/packages/deb stable main" \
 | sudo tee -a /etc/apt/sources.list.d/falcosecurity.list

sudo apt-get update -y
sudo apt-get install -y falco

# Start Falco
sudo systemctl start falco
sudo systemctl enable falco
sudo systemctl status falco

########################################
# Docker Bench Security
########################################

git clone https://github.com/docker/docker-bench-security.git
cd docker-bench-security
sudo ./docker-bench-security.sh
sudo ./docker-bench-security.sh -l /tmp/docker-bench-results.log

########################################
# Cleanup
########################################

docker stop $(docker ps -aq) 2>/dev/null
docker rm $(docker ps -aq) 2>/dev/null
docker network rm secure-network 2>/dev/null
docker image prune -f
