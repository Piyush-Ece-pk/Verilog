from PIL import Image
import numpy as np

WIDTH  = 640     # ✅ CRITICAL
HEIGHT = 427     # ✅ CRITICAL

with open("ram_dump.bin", "rb") as f:
    data = f.read()

assert len(data) == WIDTH * HEIGHT, "Size mismatch!"

img = np.frombuffer(data, dtype=np.uint8)
img = img.reshape((HEIGHT, WIDTH))

Image.fromarray(img, mode="L").save("ram_out.png")
print("PNG written successfully")
