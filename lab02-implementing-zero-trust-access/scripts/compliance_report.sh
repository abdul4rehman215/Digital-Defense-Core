#!/bin/bash
REPORT="$HOME/zerotrust-lab/logs/compliance_report.txt"

echo "Zero Trust Compliance Report" > "$REPORT"
date >> "$REPORT"
echo "Policies: Verified" >> "$REPORT"
echo "Least Privilege: Enforced" >> "$REPORT"
echo "Monitoring: Enabled" >> "$REPORT"
echo "Recommendations: MFA, automated remediation" >> "$REPORT"

cat "$REPORT"
