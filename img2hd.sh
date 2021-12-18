#! /bin/bash
echo -e "\e[32mThis script convert the jpg images in current folder to HD files using imagemagick.\n HD images will be in folder ./hd\e[0m"

mkdir hd
folder="$(zenity  --file-selection --title="Choose a directory with images (jpg&png files)" --directory)"
echo "Converting all images, please wait..."
echo $folder
cd $folder
rm ./hd/hdimg_*.*
find . -depth -name '* *' \
| while IFS= read -r f ; do mv -i "$f" "$(dirname "$f")/$(basename "$f"|tr ' ' _)" ; done
for file in *.jpg *.png; do convert $file -resize 1280 ./hd/hdimg_$file ; done 
echo "Finished"
notify-send "Done converting files in folder ./hd:"
notify-send "$folder/hd"