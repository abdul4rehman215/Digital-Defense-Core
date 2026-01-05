#!/usr/bin/env python3
import os

def analyze_directory(directory):
    images = [f for f in os.listdir(directory) if f.endswith(".png")]
    print("Image Analysis Report")

    for img in images:
        print(f"- {img}: Review recommended")

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        print("Usage: python3 batch_analyzer.py <directory>")
    else:
        analyze_directory(sys.argv[1])
