
#! /bin/bash
echo -e "\e[32mThis script convert videos to 720P@30FPS WEBM using ffmpeg in an acceptable time on 2020 CPUs(~2 times slower thzn zctual videos).\n Using -deadline good , you may try -deadline realtime. \e[0m"

folder="$(zenity  --file-selection --title="Choose a video file " --file-selection)"
echo "Converting the video, please wait (encoding will take ~same time as the duration of the video) ..."
notify-send "Converting the video, please wait for quite some time ..."
echo "$folder"
ffmpeg -i $folder -vf scale=-1:720,fps=30  -vcodec libvpx -deadline good -acodec libvorbis $folder.webm
#ffmpeg -i _____.mp4  -c:v libvpx -crf 10 -b:v 1M -c:a libvorbis ____.webm
