#! /bin/bash
echo -e "\e[32mThis script convert the jpg images in current folder to HD files using imagemagick.\n HD images will be in folder ./hd\e[0m"


folder="$(zenity  --file-selection --title="Choose a directory with images (jpg&png files)" --directory)"
echo "Converting all images, please wait..."
notify-send "img2hd : Please wait..."
mkdir $folder/hd
echo $folder
cd $folder
rm $folder/hd/hdimg_*.*
#remove spaces in files
find . -depth -name '* *' \
| while IFS= read -r f ; do mv -i "$f" "$(dirname "$f")/$(basename "$f"|tr ' ' _)" ; done
#convert images
for file in *.jpg *.jpeg *.JPG *.JPEG *.png; do convert $file -resize 1280x720 $folder/hd/hdimg_$file ; done 
echo "Finished"
notify-send "Done converting files in folder ./hd:"
notify-send "$folder/hd"
