#!/bin/bash

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

# 使用FFmpeg压缩JPEG图片
for src_file in "$src_folder"/*.{jpg,JPG,jpeg,JPEG}; do
   if [ -f "$src_file" ]; then
       file_name=$(basename "$src_file")
       dst_file="$dst_folder/$file_name"

       # 使用FFmpeg压缩图片并保存到目标文件夹
       ffmpeg -i "$src_file" -qscale:v 2 "$dst_file"
   fi
done

# 使用pngquant压缩PNG图片
for src_file in "$src_folder"/*.{png,PNG}; do
   if [ -f "$src_file" ]; then
       file_name=$(basename "$src_file")
       dst_file="$dst_folder/$file_name"

       # 使用pngquant压缩图片并保存到目标文件夹
       pngquant --quality=80-90 -f --output "$dst_file" "$src_file"
   fi
done

echo "所有图片压缩完成并保存到 $dst_folder 中。"