#!/bin/bash

# 非零返回不退出
set +e

# 检查输入参数的个数
if [ "$#" -ne 2 ]; then
   echo "用法: $0 <源图片文件夹路径> <目标文件夹路径>"
   exit 1
fi

# 读取输入参数
src_folder="$1"
dst_folder="$2"

# 检查目标文件夹是否存在，如果不存在则创建
if [ ! -d "$dst_folder" ]; then
   mkdir -p "$dst_folder"
fi

# 使用 Crunch 压缩 PNG 图片
crunch "$src_folder"/*.PNG
crunch "$src_folder"/*.png

# 将压缩后的图片移动到目标文件夹
for file in "$src_folder"/*-crunch.{png,PNG}; do
    new_filename=$(basename "$file" | sed 's/-crunch//')
    mv "$file" "$dst_folder"/"$new_filename"
done
