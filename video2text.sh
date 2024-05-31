#!/bin/bash

#INSTALL INSTRUCTIONS
#sudo apt update
#sudo apt install ffmpeg
#pip install openai-whisper


# Check if the input video file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <input_video_file>"
    exit 1
fi

INPUT_VIDEO=$1
AUDIO_FILE="extracted_audio.wav"
# Extract audio from the video file using ffmpeg
echo EXTRACTING AUDIO ...
ffmpeg -i "$INPUT_VIDEO" -q:a 0 -map a "$AUDIO_FILE"

# Transcribe the audio file to text using Whisper

python3 - <<END
print('\n_____________\n Please wait while open whisper is working...It will run all your CPUS for several minutes...')

import whisper

# Load the Whisper model
model = whisper.load_model("base")

# Transcribe the audio file
result = model.transcribe("$AUDIO_FILE")

# Save the transcription to a text file
with open("$1.txt", "w") as f:
    f.write(result["text"])

print(f"Transcription saved to {TEXT_FILE}")
END

# Clean up the audio file if needed
# rm "$AUDIO_FILE"

