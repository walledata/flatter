import glob
import os
import random
import shutil
import hashlib
import json
import argparse


used_hash = []


def generate_file_hash(filepath: str, salt: bytes = None) -> str:
    hash_function = hashlib.sha256()
    with open(filepath, "rb") as f:
        while chunk := f.read(8192):
            hash_function.update(chunk)
    hash_function.update(filepath.encode())  # 添加文件路径到hash
    if salt is not None:
        print(f"Added salt for: {filepath}")
        hash_function.update(salt)
    hash_str = hash_function.hexdigest()
    if hash_str not in used_hash:
        used_hash.append(hash_str)
        return hash_str
    return generate_file_hash(filepath, random.randbytes(8))


def move_images_to_top_level(start_dir: str, dest_dir: str, extensions: tuple[str] = (".jpg", ".png", ".gif")):
    # 转换为绝对路径
    start_dir = os.path.abspath(start_dir)
    dest_dir = os.path.abspath(dest_dir)
    # 创建目标路径
    os.makedirs(dest_dir, exist_ok=True)
    new_filename_original_path_map = {}
    for ext in extensions:
        for filepath in glob.glob(start_dir + "/**/*" + ext, recursive=True):
            directory, filename = os.path.split(filepath)
            # 计算图片的hash作为新的文件名
            new_filename = generate_file_hash(directory + "/" + filename) + ext
            # 记录文件原始的路径与新文件名的映射关系
            new_filename_original_path_map.update({new_filename: directory + "/" + filename})
            shutil.copy(filepath, dest_dir + "/" + new_filename)
    return json.dumps(new_filename_original_path_map)


def move_images_back(dest_dir, mapping_file_path):
    new_filename_original_path_map = json.load(open(mapping_file_path, "r"))
    for new_filename, original_path in new_filename_original_path_map.items():
        # 创建文件原始路径的目录结构
        os.makedirs(os.path.dirname(original_path), exist_ok=True)
        # 把文件放回原位置
        shutil.copy(dest_dir + new_filename, original_path)


def main():
    parser = argparse.ArgumentParser(
        description="Flat and restore resource directory.\nCopyright (C) 2024 Walledata.\nLicensed under GPLv3 License.",
        formatter_class=argparse.RawTextHelpFormatter,
    )
    parser.add_argument(
        "action",
        choices=["flat", "move_back"],
        help="flat - copy all images to a single level folder,"
        " move_back - restore the original resource directory structure.",
    )
    parser.add_argument(
        "start_dir",
        help="flat: original resource dir; move_back: the json file records the original resource dir structure.",
    )
    parser.add_argument("dest_dir", help="Directory where to store the flatten resource dir.")
    args = parser.parse_args()  # 解析命令行参数
    if args.action == "flat":
        print(move_images_to_top_level(args.start_dir, args.dest_dir))
    elif args.action == "move_back":
        move_images_back(args.dest_dir, args.start_dir)


if __name__ == "__main__":
    main()
