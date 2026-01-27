from PIL import Image
import numpy as np
import os

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
img_path = os.path.join(SCRIPT_DIR, "input.png")
hex_path = os.path.join(SCRIPT_DIR, "image.hex")

img = Image.open(img_path).convert("L")
pixels = np.array(img, dtype=np.uint8)

with open(hex_path, "w") as f:
    for p in pixels.flatten():
        f.write(f"{p:02x}\n")

print("image.hex generated")
