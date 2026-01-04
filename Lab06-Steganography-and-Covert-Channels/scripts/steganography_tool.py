#!/usr/bin/env python3
from PIL import Image
import numpy as np
import sys
import hashlib
import base64

class ImageSteganography:
    def __init__(self):
        self.delimiter = "###END###"

    def text_to_binary(self, text):
        return ''.join(format(ord(c), '08b') for c in text)

    def binary_to_text(self, binary_data):
        chars = [binary_data[i:i+8] for i in range(0, len(binary_data), 8)]
        text = ''.join(chr(int(c, 2)) for c in chars)
        return text

    def encrypt_message(self, message, password):
        key = hashlib.md5(password.encode()).digest()
        encrypted = bytes([ord(c) ^ key[i % len(key)] for i, c in enumerate(message)])
        return base64.b64encode(encrypted).decode()

    def decrypt_message(self, encrypted_message, password):
        key = hashlib.md5(password.encode()).digest()
        data = base64.b64decode(encrypted_message)
        return ''.join(chr(b ^ key[i % len(key)]) for i, b in enumerate(data))

    def hide_message(self, image_path, message, output_path, password=None):
        try:
            img = Image.open(image_path).convert("RGB")
            data = np.array(img)

            if password:
                message = self.encrypt_message(message, password)

            message += self.delimiter
            binary_message = self.text_to_binary(message)

            flat = data.flatten()
            if len(binary_message) > len(flat):
                raise ValueError("Message too long for image")

            for i in range(len(binary_message)):
                flat[i] = (flat[i] & 0xFE) | int(binary_message[i])

            new_data = flat.reshape(data.shape)
            Image.fromarray(new_data.astype(np.uint8)).save(output_path)

            print(f"Message successfully hidden in {output_path}")
            return True

        except Exception as e:
            print(f"Error: {e}")
            return False

    def extract_message(self, image_path, password=None):
        try:
            img = Image.open(image_path).convert("RGB")
            data = np.array(img).flatten()

            bits = ''.join(str(pixel & 1) for pixel in data)
            text = self.binary_to_text(bits)

            message = text.split(self.delimiter)[0]

            if password:
                message = self.decrypt_message(message, password)

            print("Extracted message:", message)
            return message

        except Exception as e:
            print(f"Error: {e}")
            return None

def main():
    stego = ImageSteganography()

    if len(sys.argv) < 2:
        print("Usage:")
        print(" Hide: python3 steganography_tool.py hide <image> <message> <output> [password]")
        print(" Extract: python3 steganography_tool.py extract <image> [password]")
        return

    cmd = sys.argv[1]

    if cmd == "hide":
        stego.hide_message(*sys.argv[2:])
    elif cmd == "extract":
        stego.extract_message(*sys.argv[2:])
    else:
        print("Invalid command")

if __name__ == "__main__":
    main()
