#!/usr/bin/env bash
# Run from the Flutter project ROOT (the folder that contains pubspec.yaml):
#   bash tools/setup_adhan.sh
# Copies the Adhan files to Android res/raw (required for killed-app playback) with valid
# resource names, and makes ≤29s iOS versions (iOS ignores notification sounds > 30s).
set -e
SRC="assets/audio/azan_normal"
RAW="android/app/src/main/res/raw"
IOS="ios/Runner/adhan_sounds"
mkdir -p "$RAW" "$IOS"
declare -A MAP=(
  [mohammed_refat]="mohammed_refat.mp3"
  [abdul_basit]="abdul-basit_abdul-samad.mp3"
  [al_hussary]="al_hussary.mp3"
  [ali_mulla]="ali_ahmed_mulla.mp3"
  [minshawi]="El-Minshawi.mp3"
  [essam_bukhari]="essam-bukhari.MP3"
  [naji_qazzaz]="naji-qazzaz.mp3"
  [naqshabandy]="naqshabandy.mp3"
  [nayef_fida]="nayef_fida.mp3"
)
for id in "${!MAP[@]}"; do
  f="$SRC/${MAP[$id]}"
  [ -f "$f" ] || { echo "MISSING: $f"; continue; }
  cp "$f" "$RAW/azan_${id}.mp3"
  if command -v ffmpeg >/dev/null; then
    ffmpeg -y -loglevel error -i "$f" -t 29 -af "afade=t=out:st=27:d=2" "$IOS/azan_${id}.mp3"
  else
    cp "$f" "$IOS/azan_${id}.mp3"; echo "ffmpeg not found: iOS file for $id not trimmed"
  fi
  echo "ok  $id"
done
echo "Android: done. iOS: add the files in $IOS to Xcode (Runner target > Copy Bundle Resources)."
