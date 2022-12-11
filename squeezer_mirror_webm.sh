
#! /bin/bash
echo -e "\e[32m SQUEEZ & Mirror your video meeting to send it via email (10Mo for 15 min)  \e[0m"

folder="$(zenity  --file-selection --title="Choose a video file to MIRROR quickely in webm " --file-selection)"
echo "Converting the video, please wait (encoding will take ~same time as the duration of the video) ..."
notify-send "Converting the video, please wait for quite some time ..."
echo "$folder"
ffmpeg -i $folder -vf scale=-1:720,fps=1,hflip  -vcodec libvpx -deadline realtime -acodec libvorbis -qscale:a 0.1 -ac 1 -ar 22050 $folder.webm
#ffmpeg -i _____.mp4  -c:v libvpx -crf 10 -b:v 1M -c:a libvorbis ____.webm
#ffmpeg -i $folder -vf scale=-1:720,fps=30  -vcodec libvpx -deadline good -acodec libvorbis $folder.webm
#ffmpeg -i X.mp4 -vf scale=-1:720,fps=30  -vcodec libvpx -deadline good -acodec libvorbis X.webm
