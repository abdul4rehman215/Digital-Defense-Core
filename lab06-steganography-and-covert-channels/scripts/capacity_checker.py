#!/usr/bin/env python3
from PIL import Image
import sys

def calculate_capacity(image_path):
    img = Image.open(image_path)
    width, height = img.size
    total_bits = width * height * 3
    max_chars = (total_bits // 8) - 10

    print(f"Image: {image_path}")
    print(f"Resolution: {width}x{height}")
    print(f"Max hidden characters: {max_chars}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 capacity_checker.py <image>")
    else:
        calculate_capacity(sys.argv[1])
