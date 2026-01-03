#!/usr/bin/env python3
import string
import secrets
from password_policy import PasswordPolicyChecker

class SecurePasswordGenerator:
    def __init__(self):
        self.policy = PasswordPolicyChecker()
        self.upper = string.ascii_uppercase
        self.lower = string.ascii_lowercase
        self.digits = string.digits
        self.special = "!@#$%^&*()_+-=[]{}|;:,.<>?"

    def generate_password(self, length=12):
        if length < 8:
            length = 8
        pwd = [
            secrets.choice(self.upper),
            secrets.choice(self.lower),
            secrets.choice(self.digits),
            secrets.choice(self.special),
        ]
        all_chars = self.upper + self.lower + self.digits + self.special
        while len(pwd) < length:
            pwd.append(secrets.choice(all_chars))
        secrets.SystemRandom().shuffle(pwd)
        pwd = "".join(pwd)
        return pwd if self.policy.validate_password(pwd)[0] else self.generate_password(length)

    def generate_multiple_passwords(self, count=5, length=12):
        return [self.generate_password(length) for _ in range(count)]

def main():
    gen = SecurePasswordGenerator()
    while True:
        print("1. Generate single password")
        print("2. Generate multiple passwords")
        print("3. Custom length password")
        print("4. Exit")
        c = input("Choice: ")
        if c == "1":
            print(gen.generate_password())
        elif c == "2":
            for p in gen.generate_multiple_passwords():
                print(p)
        elif c == "3":
            l = int(input("Length: "))
            print(gen.generate_password(l))
        elif c == "4":
            break

if __name__ == "__main__":
    main()
