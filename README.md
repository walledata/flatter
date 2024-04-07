# Flatter

**资源目录展平与图片压缩**

## 安装依赖

* macOS直接执行

  ```shell
  ./setup.sh
  ```

* 其他操作系统需要将`setup.sh`中的`brew`安装命令替换为对应系统的包管理器安装命令

## 全自动脚本

一键执行`目录展平 -> 压缩图片 -> 恢复目录结构`(仍然需要先在运行的机器上安装`ffmpeg`, ~~`pngquant`~~, `crunch`)

```shell
./main.sh <源图片文件夹路径> <目标文件夹路径>
```

## 资源目录展平与还原

*目前版本完全基于标准库编写，不需要安装除python3解释器本身以外的任何依赖。*

查看帮助

```shell
python3 flatter.py -h
```

帮助内容如下：

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

    
