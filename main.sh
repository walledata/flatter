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

# 创建临时目录
mkdir tmp # 存放展平后的所有原始图片
mkdir tmp_compressed # 存放压缩后的图片

# 展平资源目录
python3 flatter.py flat "$src_folder" ./tmp > map.json

# 压缩图片
./compress.sh ./tmp ./tmp_compressed

# 对 map.json 中的路径做替换，避免还原原始目录结构时覆盖原始文件
# 清除src_folder变量的"./"前缀（如果存在）
clean_src_folder="${src_folder#./}"
clean_dst_folder="${dst_folder#./}"
# 获取当前工作目录
current_dir=$(pwd)
# 构造sed的搜索模式
search_pattern="${current_dir}/${clean_src_folder}"
# 构造sed的替换模式
replace_pattern="${current_dir}/${clean_dst_folder}"
# 替换
sed -i '' "s|${search_pattern}|${replace_pattern}|g" ./map.json

# 恢复原始目录结构
python3 flatter.py move_back ./map.json ./tmp_compressed/

# 清理
#rm -rf ./tmp ./tmp_compressed
