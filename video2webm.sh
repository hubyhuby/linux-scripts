
#! /bin/bash
echo -e "\e[32mThis script convert the files to WEBM using ffmpeg.\n \e[0m"

folder="$(zenity  --file-selection --title="Choose a MP4 file " --file-selection)"
echo "Converting the video, please wait..."
notify-send "Converting the video, please wait..."
echo "$folder"
ffmpeg -i $folder -vcodec libvpx -acodec libvorbis $folder.webm
