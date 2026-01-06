#!/bin/bash
AUDIT_LOG="/opt/cloud-security-lab/logs/security-audit-$(date +%Y%m%d-%H%M%S).log"
HTML_REPORT="/opt/cloud-security-lab/logs/security-report.html"

perform_audit() {
 echo "=== CLOUD SECURITY AUDIT ($(date)) ===" | tee "$AUDIT_LOG"

 echo -e "\n[1] SYSTEM UPDATES" | tee -a "$AUDIT_LOG"
 apt list --upgradable 2>/dev/null | head -10 | tee -a "$AUDIT_LOG"

 echo -e "\n[2] USER ACCOUNTS" | tee -a "$AUDIT_LOG"
 grep -E ":/bin/(bash|sh)$" /etc/passwd | tee -a "$AUDIT_LOG"

 echo -e "\n[3] SUDO CONFIGURATION" | tee -a "$AUDIT_LOG"
 grep -v "^#" /etc/sudoers | grep -v "^$" | tee -a "$AUDIT_LOG"

 echo -e "\n[4] RUNNING SERVICES" | tee -a "$AUDIT_LOG"
 systemctl list-units --type=service --state=running --no-pager | tee -a "$AUDIT_LOG"

 echo -e "\n[5] OPEN PORTS" | tee -a "$AUDIT_LOG"
 netstat -tuln | grep LISTEN | tee -a "$AUDIT_LOG"

 echo -e "\n[6] FIREWALL STATUS" | tee -a "$AUDIT_LOG"
 ufw status verbose | tee -a "$AUDIT_LOG"

 echo -e "\n[7] FAILED LOGIN ATTEMPTS" | tee -a "$AUDIT_LOG"
 grep "Failed password" /var/log/auth.log | tail -5 | tee -a "$AUDIT_LOG"

 echo -e "\n[8] DISK USAGE" | tee -a "$AUDIT_LOG"
 df -h | tee -a "$AUDIT_LOG"

 echo -e "\n=== AUDIT COMPLETE ===" | tee -a "$AUDIT_LOG"
}

generate_html() {
 cat > "$HTML_REPORT" << EOF
<!DOCTYPE html>
<html>
<head>
<title>Cloud Security Audit Report</title>
<style>
body { font-family: Arial; }
h1 { background:#2c3e50;color:white;padding:10px; }
pre { background:#f4f4f4;padding:10px; }
</style>
</head>
<body>
<h1>Cloud Security Audit Report</h1>
<p>Generated: $(date)</p>
<pre>$(cat "$AUDIT_LOG")</pre>
</body>
</html>
EOF
}

perform_audit
generate_html

echo "Audit reports generated:"
echo " - $AUDIT_LOG"
echo " - $HTML_REPORT"
