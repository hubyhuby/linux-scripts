
#! /bin/bash
echo -e "\e[32mThis script convert videos very quickely and MIRROR horizontaly for OBS videos WEBM using ffmpeg. It retains audio and crunch as much as possible the video to send it via email  \e[0m"

folder="$(zenity  --file-selection --title="Choose a video file to MIRROR quickely in webm " --file-selection)"
echo "Converting the video, please wait (encoding will take ~same time as the duration of the video) ..."
notify-send "Converting the video, please wait for quite some time ..."
echo "$folder"
ffmpeg -i $folder -vf scale=-1:480,fps=5,hflip  -vcodec libvpx -deadline realtime -acodec libvorbis $folder.webm
#ffmpeg -i _____.mp4  -c:v libvpx -crf 10 -b:v 1M -c:a libvorbis ____.webm
#ffmpeg -i $folder -vf scale=-1:720,fps=30  -vcodec libvpx -deadline good -acodec libvorbis $folder.webm
#ffmpeg -i X.mp4 -vf scale=-1:720,fps=30  -vcodec libvpx -deadline good -acodec libvorbis X.webm
