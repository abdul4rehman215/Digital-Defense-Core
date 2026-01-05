#!/usr/bin/env python3
import html
import re

class XSSProtector:
    def __init__(self):
        self.allowed_tags = ["b", "i", "u"]
        self.dangerous_attrs = ["onerror", "onclick", "onload"]

    def html_encode(self, input_string):
        return html.escape(input_string)

    def remove_dangerous_tags(self, input_string):
        input_string = re.sub(
            r"<\s*script.*?>.*?<\s*/\s*script\s*>",
            "",
            input_string,
            flags=re.I | re.S
        )
        input_string = re.sub(
            r"<\s*iframe.*?>.*?<\s*/\s*iframe\s*>",
            "",
            input_string,
            flags=re.I | re.S
        )

        for attr in self.dangerous_attrs:
            input_string = re.sub(
                fr"{attr}\s*=\s*['\"].*?['\"]",
                "",
                input_string,
                flags=re.I
            )
        return input_string

    def sanitize_input(self, input_string, method="encode"):
        if method == "encode":
            return self.html_encode(input_string)
        elif method == "strip":
            return self.remove_dangerous_tags(input_string)
        elif method == "whitelist":
            return re.sub(
                r"</?(?!b|i|u)\w+[^>]*>",
                "",
                input_string,
                flags=re.I
            )
        return input_string

    def validate_and_sanitize(self, input_string):
        is_malicious = bool(
            re.search(r"<\s*script|javascript\s*:|on\w+\s*=", input_string, re.I)
        )
        sanitized = self.html_encode(input_string) if is_malicious else input_string
        return sanitized, not is_malicious, {"malicious": is_malicious}

def main():
    protector = XSSProtector()

    test_cases = [
        "Normal text",
        "<script>alert('XSS')</script>",
        "<img src=x onerror=alert(1)>",
        "<b>Bold</b> text"
    ]

    for case in test_cases:
        print("\nInput:", case)
        print("Encoded:", protector.sanitize_input(case, "encode"))
        print("Stripped:", protector.sanitize_input(case, "strip"))

if __name__ == "__main__":
    main()
