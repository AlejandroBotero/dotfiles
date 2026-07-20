#!/bin/bash
# Pick wallpaper deterministically by day-of-year, so it changes once per day.

WALLPAPER_DIR="$HOME/dotfiles/wallpapers"

mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) | sort)
COUNT=${#WALLPAPERS[@]}
[ "$COUNT" -eq 0 ] && exit 0

DAY=$(date +%j)         # 001-366, leading zeros
IDX=$(( 10#$DAY % COUNT )) # 10# forces base-10, avoids octal parse error

feh "${WALLPAPERS[$IDX]}" --bg-scale
