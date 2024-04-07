#!/bin/bash

# Install FFmpeg
brew install ffmpeg   # Only for macOS, replace `brew` with your package management tool

## Install pngquant
#git clone --recursive https://github.com/kornelski/pngquant.git
#cd pngquant
#cargo build --release --features=cocoa
#sudo mv target/release/pngquant /usr/local/bin/pngquant

# Install Crunch
git clone https://github.com/chrissimpkins/Crunch.git
cd Crunch
make build-dependencies
make install-executable # This needs sudo privilege

# Check if setup successful
which ffmpeg
which crunch
