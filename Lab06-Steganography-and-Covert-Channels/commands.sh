#!/bin/bash

# Lab 6: Steganography and Covert Channels
# commands.sh
# Environment: Ubuntu 24.04.1 LTS
# User: toor

# -------------------------------
# Task 1: Setup & Dependencies
# -------------------------------

mkdir ~/steganography_lab
cd ~/steganography_lab

pip3 install --user Pillow numpy matplotlib

# -------------------------------
# Task 1: Create Test Images
# -------------------------------

python3 << 'EOF'
from PIL import Image
import numpy as np

width, height = 400, 300
image_array = np.random.randint(0, 256, (height, width, 3), dtype=np.uint8)
test_image = Image.fromarray(image_array, 'RGB')
test_image.save('test_image.png')

solid_image = Image.new('RGB', (400, 300), color='blue')
solid_image.save('blue_image.png')

print("Test images created successfully!")
EOF

ls -lh *.png

# -------------------------------
# Task 1: LSB Demonstration
# -------------------------------

nano understanding_lsb.py
python3 understanding_lsb.py

# -------------------------------
# Task 2: Steganography Tool
# -------------------------------

nano steganography_tool.py
chmod +x steganography_tool.py

python3 steganography_tool.py hide test_image.png "Secret message!" hidden.png
python3 steganography_tool.py extract hidden.png

# -------------------------------
# Task 3: Capacity Checker
# -------------------------------

nano capacity_checker.py
chmod +x capacity_checker.py
python3 capacity_checker.py test_image.png

# -------------------------------
# Task 3: Password Protection
# -------------------------------

python3 steganography_tool.py hide test_image.png "Secret!" secure.png mypass123
python3 steganography_tool.py extract secure.png mypass123
python3 steganography_tool.py extract secure.png wrongpass

# -------------------------------
# Task 4: Detection Tool
# -------------------------------

nano stego_detector.py
chmod +x stego_detector.py

python3 stego_detector.py test_image.png
python3 stego_detector.py hidden.png

# -------------------------------
# Task 4: Batch Analyzer
# -------------------------------

nano batch_analyzer.py
python3 batch_analyzer.py .
