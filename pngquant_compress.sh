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

# 使用pngquant压缩PNG图片
for src_file in "$src_folder"/*.{png,PNG}; do
   if [ -f "$src_file" ]; then
      file_name=$(basename "$src_file")
      dst_file="$dst_folder/$file_name"

      # 使用pngquant压缩图片并保存到目标文件夹
      pngquant --quality=80-90 -f --output "$dst_file" "$src_file"

      # 捕获pngquant的退出状态码
      exit_code=$?

      # 检查退出状态码
      if [ $exit_code -ne 0 ]; then
         # pngquant状态码99代表原图的色位数少于quality=80对应的最少色位数，通常是icon这类非常小的图片
         echo "压缩失败: $src_file (Exit Code: $exit_code), 将原始文件拷贝到目标位置"
         cp "$src_file" "$dst_file"
      fi
   fi
done