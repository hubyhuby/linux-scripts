
#! /bin/bash
echo -e "\e[32m UNTESTED : should compile and install Grive 2\e[0m"
#https://github.com/vitalif/grive2/issues/374
read -rsp $'Press any key to continue...\n' -n1 key

echo"Download dependency before compiling"
sudo apt-get install git cmake build-essential libgcrypt20-dev libyajl-dev \
    libboost-all-dev libcurl4-openssl-dev libexpat1-dev libcppunit-dev binutils-dev \
    debhelper zlib1g-dev dpkg-dev pkg-config

echo " download project + compile + install"

git clone https://github.com/vitalif/grive2.git
cd grive2
mkdir build
cd build
cmake ..
sudo make -j4 install
