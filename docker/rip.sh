#!/bin/bash

DEVICE="/dev/sr0"
OUTPUT_DIR="/data/output"
mkdir -p "$OUTPUT_DIR"

echo "Scanning DVD..."
HandBrakeCLI -i "$DEVICE" --scan

read -p "Enter the number for the title (e.g. 1 or 2): " TITLE_NUM
read -p "Enter the number for the Audio (mostly 1): " AUDIO_TRACK
read -p "Enter the number for the Subtitles (0 for none): " SUBTITLE_TRACK

CMD=(HandBrakeCLI -i "$DEVICE" -t "$TITLE_NUM" -o "$OUTPUT_DIR/DVD_$(date +%F_%H-%M-%S).mkv" \
  -e x264 -q 18 -B 160 --format mkv --optimize \
  --audio "$AUDIO_TRACK" --audio-copy-mask aac,ac3,dts --audio-fallback ffaac)

if [ "$SUBTITLE_TRACK" != "0" ]; then
  CMD+=("--subtitle" "$SUBTITLE_TRACK")
fi

echo "Starting ripping $TITLE_NUM with Audio $AUDIO_TRACK and Subtitles $SUBTITLE_TRACK"
"${CMD[@]}"
