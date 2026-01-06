#!/bin/bash
# Cleanup script for Lab 15

echo "Stopping and removing containers..."
docker stop $(docker ps -aq) 2>/dev/null
docker rm $(docker ps -aq) 2>/dev/null

echo "Removing secure network..."
docker network rm secure-network 2>/dev/null

echo "Pruning unused images..."
docker image prune -f

echo "Removing temporary scan files..."
rm -f *.json *.txt *.sh vuln-report.json scan-results.json

echo "Cleanup completed successfully."
