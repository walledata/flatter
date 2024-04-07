# Flatter

**资源目录展平与图片压缩**

## 安装依赖

* macOS直接执行

  ```shell
  ./setup.sh
  ```

* 其他操作系统需要将`setup.sh`中的`brew`安装命令替换为对应系统的包管理器安装命令

## 全自动脚本

一键执行`目录展平 -> 压缩图片 -> 恢复目录结构`(需要先[安装依赖](#安装依赖))

```shell
./main.sh <源图片文件夹路径> <目标文件夹路径>
```

---

*以下非必读*

## 资源目录展平与还原

*目前版本完全基于标准库编写，不需要安装除python3解释器本身以外的任何依赖。*

* 查看帮助

  ```shell
  python3 flatter.py -h
  ```

  帮助内容如下：

  ```
  usage: flatter.py [-h] {flat,move_back} start_dir dest_dir
  
  Flat and restore resource directory.
  Copyright (C) 2024 Walledata.
  Licensed under GPLv3 License.
  
  positional arguments:
    {flat,move_back}  flat - copy all images to a single level folder, move_back - restore the original resource directory structure.
    start_dir         flat: original resource dir; move_back: the json file records the original resource dir structure.
    dest_dir          Directory where to store the flatten resource dir.
  
  options:
    -h, --help        show this help message and exit
  ```

* 目录展平

  ```shell
  python3 flatter.py flat <your_resource_folder> ./tmp > map.json
  ```

* 目录还原

  ```shell
  python3 flatter.py move_back ./map.json ./tmp
  ```

  **注意：**执行还原会将展平后的文件再复制回原始的资源目录，会进行文件覆盖，虽然理论上仍然是用相同的文件覆盖，但是保险期间还是建议先对`map.json`做字符替换处理（具体可以参考`main.sh`中的实现），或者先将原始的资源目录备份

## 图片压缩

* 使用`ffmpeg`压缩`.jpg`图片，使用~~`pngquant`~~`crunch`压缩`.png`图片

* 安装[FFmpeg](https://github.com/FFmpeg/FFmpeg):

  ```shell
  brew install ffmpeg
  ```

* ~~安装[pngquant](https://github.com/kornelski/pngquant):~~

  ```shell
  git clone --recursive https://github.com/kornelski/pngquant.git
  cd pngquant
  cargo build --release --features=cocoa
  sudo mv target/release/pngquant /usr/local/bin/pngquant
  ```

* 安装[Crunch](https://github.com/chrissimpkins/Crunch):

  [Install Crunch.](https://github.com/chrissimpkins/Crunch/blob/master/docs/EXECUTABLE.md#install)

  ```shell
  git clone https://github.com/chrissimpkins/Crunch.git
  make build-dependencies
  make install-executable
  ```
  
* 压缩示例：

  * 待压缩图片放在`./input/`(假设目录已做过展平处理)

  * 压缩后的图片保存到`./output/`

  * 压缩

    ```shell
    ./compress.sh ./input ./output
    ```

    
