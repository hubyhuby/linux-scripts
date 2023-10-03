#!/bin/bash

input_file=$(zenity --file-selection --title="Select Input Video File")

if [ -n "$input_file" ]; then
   input_file_dir=$(dirname "$input_file")
   input_file_name=$(basename "$input_file")
   input_file_extension="${input_file_name##*.}"
   input_file_name="${input_file_name%.*}"

   output_file="$input_file_dir/$input_file_name""_VBR.mp4"

   ffmpeg -i "$input_file" -b:v 2.5M "$output_file"
   echo "Video converted and saved as $output_file"
else
   echo "No file selected."
fi

