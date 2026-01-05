#!/usr/bin/env python3
def demonstrate_lsb():
    original_pixel = 170
    print(f"Original pixel: {original_pixel} = {format(original_pixel, '08b')}")

    message_bit = 1
    print(f"Message bit to hide: {message_bit}")

    modified_pixel = (original_pixel & 0xFE) | message_bit
    print(f"Modified pixel: {modified_pixel} = {format(modified_pixel, '08b')}")
    print(f"Difference: {abs(original_pixel - modified_pixel)}")

    extracted_bit = modified_pixel & 1
    print(f"Extracted bit: {extracted_bit}")
    print(f"Match: {extracted_bit == message_bit}")

if __name__ == "__main__":
    demonstrate_lsb()
