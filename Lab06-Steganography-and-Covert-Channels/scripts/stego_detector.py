#!/usr/bin/env python3
from PIL import Image
import numpy as np
import sys
import math

class SteganographyDetector:

    def chi_square_test(self, image_path):
        img = Image.open(image_path).convert("RGB")
        data = np.array(img).flatten()
        lsb = data & 1

        ones = np.sum(lsb)
        zeros = len(lsb) - ones
        expected = len(lsb) / 2

        chi_square = ((zeros - expected) ** 2 + (ones - expected) ** 2) / expected
        print(f"Chi-square value: {chi_square:.2f}")
        print("Suspicious" if chi_square < 3.841 else "Likely clean")

    def entropy_analysis(self, image_path):
        img = Image.open(image_path).convert("RGB")
        data = np.array(img).flatten() & 1
        p1 = np.mean(data)
        p0 = 1 - p1

        entropy = 0
        for p in [p0, p1]:
            if p > 0:
                entropy -= p * math.log2(p)

        print(f"LSB entropy: {entropy:.3f}")

    def visual_analysis(self, image_path, output_path):
        img = Image.open(image_path).convert("RGB")
        data = np.array(img)
        lsb = (data & 1) * 255
        Image.fromarray(lsb.astype(np.uint8)).save(output_path)
        print(f"LSB visualization saved as {output_path}")

def main():
    detector = SteganographyDetector()

    if len(sys.argv) != 2:
        print("Usage: python3 stego_detector.py <image>")
        return

    print("=== Steganography Detection Analysis ===")
    detector.chi_square_test(sys.argv[1])
    detector.entropy_analysis(sys.argv[1])
    detector.visual_analysis(sys.argv[1], "lsb_visualization.png")

if __name__ == "__main__":
    main()
