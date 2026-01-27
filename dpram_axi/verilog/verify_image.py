from PIL import Image
import numpy as np

# Load original
orig = Image.open("input.png").convert("L")
orig_px = np.array(orig, dtype=np.uint8)

# Load RAM dump
dump = np.fromfile("ram_dump.bin", dtype=np.uint8)
dump = dump.reshape(orig_px.shape)

# Save reconstructed image
out = Image.fromarray(dump, mode="L")
out.save("output.png")

# Compare
diff = np.abs(orig_px.astype(int) - dump.astype(int))
errors = np.count_nonzero(diff)

print("Pixel errors:", errors)
if errors == 0:
    print("PASS ✅ Image perfectly preserved")
else:
    print("FAIL ❌ Data mismatch")
