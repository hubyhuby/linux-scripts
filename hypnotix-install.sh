#https://github.com/linuxmint/hypnotix/tags
# worked for me  on my  ubuntu mate 20.04
#NO WARRANTY
echo -e " This script installs hypnotix 2.6. Do not use if you don t know what you are doing ;)"
read -p "Press any key to resume ..."

sudo apt-get install git debhelper
cd ~/Downloads
git clone https://github.com/linuxmint/hypnotix -b 2.6
cd hypnotix
dpkg-buildpackage -uc -us
sudo apt-get install ../hypnotix_2.6_all.deb
