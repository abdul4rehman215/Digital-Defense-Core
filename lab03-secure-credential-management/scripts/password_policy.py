#!/usr/bin/env python3
import re
from datetime import datetime

class PasswordPolicyChecker:
    def __init__(self):
        self.min_length = 8
        self.max_length = 128
        self.require_uppercase = True
        self.require_lowercase = True
        self.require_digits = True
        self.require_special = True
        self.special_chars = "!@#$%^&*()_+-=[]{}|;:,.<>?"

    def check_length(self, password):
        if len(password) < self.min_length:
            return False, "Password too short"
        if len(password) > self.max_length:
            return False, "Password too long"
        return True, "Length OK"

    def check_uppercase(self, password):
        return (True, "Uppercase OK") if re.search(r"[A-Z]", password) else (False, "Missing uppercase")

    def check_lowercase(self, password):
        return (True, "Lowercase OK") if re.search(r"[a-z]", password) else (False, "Missing lowercase")

    def check_digits(self, password):
        return (True, "Digit OK") if re.search(r"[0-9]", password) else (False, "Missing digit")

    def check_special_chars(self, password):
        return (True, "Special OK") if any(c in self.special_chars for c in password) else (False, "Missing special char")

    def check_common_patterns(self, password):
        weak = ["123456", "password", "qwerty", "admin"]
        for w in weak:
            if w in password.lower():
                return False, f"Weak pattern detected: {w}"
        return True, "No weak patterns"

    def validate_password(self, password):
        checks = [
            self.check_length,
            self.check_uppercase,
            self.check_lowercase,
            self.check_digits,
            self.check_special_chars,
            self.check_common_patterns
        ]
        results = []
        valid = True
        for check in checks:
            status, msg = check(password)
            results.append((status, msg))
            if not status:
                valid = False
        return valid, results

def main():
    checker = PasswordPolicyChecker()
    while True:
        pwd = input("Enter password to validate (or exit): ")
        if pwd.lower() == "exit":
            break
        valid, results = checker.validate_password(pwd)
        for r in results:
            print("[PASS]" if r[0] else "[FAIL]", r[1])
        print("Overall:", "VALID" if valid else "INVALID")

if __name__ == "__main__":
    main()
