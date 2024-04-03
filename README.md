```
usage: flatter.py [-h] {flat,move_back} start_dir dest_dir

图片资源目录展平与复原 | 展平示例: flatter flat ./tiantianbaiyin/ ./target/ > map.json | 还原示例: flatter move_back map.json ./target/

positional arguments:
  {flat,move_back}  flat - 展平, move_back - 还原
  start_dir         展平操作：原始图片资源目录；还原操作：记录原始路径的json文件
  dest_dir          存放展平后图片的目录

options:
  -h, --help        show this help message and exit
```
