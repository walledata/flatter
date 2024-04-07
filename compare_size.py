import os
import sys


def compare(original_dir: str, compressed_dir: str):
    original_images = os.listdir(original_dir)
    print(f"Found {len(original_images)} images in original directory.")
    compressed_images = os.listdir(compressed_dir)
    print(f"Found {len(compressed_images)} images in compressed directory.")
    for original_image in original_images:
        if original_image not in compressed_images:
            print(f"[Error] No compressed image for {original_image}")
            continue
        original_image_path = os.path.join(original_dir, original_image)
        compressed_image_path = os.path.join(compressed_dir, original_image)
        original_image_size = os.path.getsize(original_image_path)
        compressed_image_size = os.path.getsize(compressed_image_path)
        if original_image_size <= compressed_image_size:
            print(f"[Warning] Compressed image size is larger or equal to original image {original_image}")
            continue
        print(f"[Success] Compressed image size is smaller than original image {original_image}")


if __name__ == "__main__":
    compare(sys.argv[1], sys.argv[2])
