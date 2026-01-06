# 🛠️ Troubleshooting – Lab 19: Log Management with SIEM Tools (ELK Stack)

This document lists common issues encountered during the ELK Stack SIEM lab
and provides verified resolution steps exactly aligned with the lab workflow.

---

## Issue 1: Elasticsearch Won't Start

### Symptoms
- `elasticsearch.service` fails to start
- Port `9200` not listening
- Kibana shows connection errors

### Checks
```bash
java -version
````

Elasticsearch requires Java 11.

```bash
sudo systemctl status elasticsearch
sudo journalctl -u elasticsearch -f
```

### Fixes

* Ensure minimum **2 GB RAM** is available
* Verify Elasticsearch configuration file:

```bash
sudo nano /etc/elasticsearch/elasticsearch.yml
```

Required entries:

```yaml
network.host: localhost
http.port: 9200
discovery.type: single-node
xpack.security.enabled: false
```

Restart service:

```bash
sudo systemctl restart elasticsearch
```

---

## Issue 2: Logstash Not Processing Logs

### Symptoms

* No logs appearing in Elasticsearch
* Indices not created
* Logstash service running but idle

### Checks

```bash
sudo systemctl status logstash
sudo journalctl -u logstash -f
```

Test Logstash configuration:

```bash
sudo /usr/share/logstash/bin/logstash \
--config.test_and_exit \
-f /etc/logstash/conf.d/siem-pipeline.conf
```

### Fixes

* Ensure log file paths exist:

```bash
ls -l /var/log/auth.log
ls -l /var/log/apache2/access.log
```

* Verify permissions:

```bash
sudo chmod 644 /var/log/auth.log
sudo chmod 644 /var/log/apache2/access.log
```

Restart Logstash:

```bash
sudo systemctl restart logstash
```

---

## Issue 3: Kibana Not Accessible on Port 5601

### Symptoms

* Browser cannot load `http://localhost:5601`
* Connection refused or timeout

### Checks

```bash
sudo systemctl status kibana
sudo journalctl -u kibana -f
```

Verify port:

```bash
ss -tlnp | grep 5601
```

### Fixes

Edit Kibana config:

```bash
sudo nano /etc/kibana/kibana.yml
```

Ensure:

```yaml
server.port: 5601
server.host: "localhost"
elasticsearch.hosts: ["http://localhost:9200"]
```

Restart:

```bash
sudo systemctl restart kibana
```

---

## Issue 4: No Logs Visible in Kibana Discover

### Symptoms

* Kibana UI loads but shows no data
* Index pattern missing

### Fixes

Verify indices:

```bash
curl localhost:9200/_cat/indices?v
```

Create index pattern:

```bash
curl -X POST "localhost:5601/api/saved_objects/index-pattern/siem-logs-*" \
-H "kbn-xsrf: true" \
-H "Content-Type: application/json" \
-d '{"attributes":{"title":"siem-logs-*","timeFieldName":"@timestamp"}}'
```

Set time range to **Last 24 hours** in Discover.

---

## Issue 5: Real-Time Monitor Script Not Producing Alerts

### Symptoms

* `realtime-monitor.sh` running but no alerts logged

### Checks

```bash
ls -l ~/siem-analysis/alerts.log
```

Generate test activity:

```bash
ssh invaliduser@localhost
curl http://localhost/nonexistent-page
```

### Fix

Ensure script is executable:

```bash
chmod +x realtime-monitor.sh
```

Run script in foreground:

```bash
./realtime-monitor.sh
```

---

## Issue 6: Log Rotation Not Working

### Symptoms

* Logs not rotating
* Disk usage increasing

### Checks

```bash
sudo logrotate -d /etc/logrotate.d/siem-logs
```

### Fix

Force rotation:

```bash
sudo logrotate -f /etc/logrotate.d/siem-logs
```

Verify:

```bash
ls -lh /var/log/apache2/
ls -lh /var/log/auth.log*
```

---

## Issue 7: Elasticsearch Indices Exist but Empty

### Checks

```bash
curl localhost:9200/siem-logs-*/_search?pretty
```

### Fix

Generate fresh events:

```bash
./generate-test-data.sh
```

Wait 1–2 minutes and refresh Kibana.

---

## Final Note

If all services are running and logs are generated,
the ELK Stack will ingest, index, and visualize data automatically.

This mirrors real SOC troubleshooting workflows.
