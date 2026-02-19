#!/usr/bin/env bash

# Check for Spotify specifically (ignore other players like YouTube)
spotify_status="$(playerctl -p spotify status 2>/dev/null)"

if [ "$spotify_status" = "Playing" ] || [ "$spotify_status" = "Paused" ]; then
  artist_title="$(playerctl -p spotify metadata --format '  {{ artist }} - {{ title }}' 2>/dev/null)"
  class="${spotify_status,,}"
  echo "{\"text\": \"$artist_title\", \"class\": \"$class\"}"
  exit 0
fi

# Check for MPD/rmpc via mpc (using port 12000)
if command -v mpc &>/dev/null; then
  mpc_status=$(mpc -p 12000 status 2>/dev/null)
  if [ -n "$mpc_status" ] && [[ "$mpc_status" == *"[playing]"* ]]; then
    song=$(mpc -p 12000 current 2>/dev/null)
    if [ -n "$song" ]; then
      echo "{\"text\": \"  $song\", \"class\": \"playing\"}"
      exit 0
    fi
  elif [ -n "$mpc_status" ] && [[ "$mpc_status" == *"[paused]"* ]]; then
    song=$(mpc -p 12000 current 2>/dev/null)
    if [ -n "$song" ]; then
      echo "{\"text\": \"  $song\", \"class\": \"paused\"}"
      exit 0
    fi
  fi
fi

# No music playing from allowed sources
echo "{\"text\": \"No music for you my friend\", \"class\": \"stopped\"}"
