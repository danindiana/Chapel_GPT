#!/bin/bash

# Update package lists
sudo apt-get update

# Install necessary packages
sudo apt-get install -y curl gcc g++ m4 perl python3 python3-dev bash make mawk git pkg-config libcurl4-openssl-dev libssl-dev libmysqlclient-dev libpq-dev libsqlite3-dev libgmp-dev zlib1g-dev llvm-12-dev llvm-12-runtime ninja-build

# Download and extract Chapel
curl -O https://github.com/chapel-lang/chapel/releases/download/1.29.0/chapel-1.29.0.tar.gz
tar -xzf chapel-1.29.0.tar.gz
cd chapel-1.29.0

# Build Chapel
source util/setchplenv.bash
make

# Install Chapel
sudo make install

# Set environment variables
echo "export CHPL_HOME=/usr/local/chapel-1.29.0" >> ~/.bashrc
echo "export PATH=$PATH:/usr/local/chapel-1.29.0/bin/linux64:/usr/local/chapel-1.29.0/util" >> ~/.bashrc

# Source the .bashrc file to apply changes
source ~/.bashrc

# Verify the installation
chpl --version
