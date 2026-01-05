#!/usr/bin/env python3
import re
import sys
from datetime import datetime

class XSSDetector:
    def __init__(self):
        self.xss_patterns = [
            r"<\s*script.*?>",
            r"javascript\s*:",
            r"onerror\s*=",
            r"onclick\s*=",
            r"<\s*iframe.*?>",
            r"<\s*svg.*?>"
        ]

    def detect_xss(self, input_string):
        matches = []
        for pattern in self.xss_patterns:
            if re.search(pattern, input_string, re.IGNORECASE):
                matches.append(pattern)

        risk = self.calculate_risk_level(len(matches))
        return bool(matches), matches, risk

    def calculate_risk_level(self, matches):
        if matches >= 3:
            return "HIGH"
        elif matches == 2:
            return "MEDIUM"
        elif matches == 1:
            return "LOW"
        return "NONE"

    def log_detection(self, input_string, result):
        with open("/tmp/xss_detection.log", "a") as f:
            f.write(f"{datetime.now()} | {input_string} | {result}\n")

def main():
    detector = XSSDetector()

    if len(sys.argv) > 1:
        input_data = sys.argv[1]
        result = detector.detect_xss(input_data)
        detector.log_detection(input_data, result)

        print("Malicious:", result[0])
        print("Detected patterns:", result[1])
        print("Risk level:", result[2])
    else:
        print("Usage: python3 xss_detector.py '<input>'")

if __name__ == "__main__":
    main()
