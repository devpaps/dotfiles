#!/usr/bin/env bash

status="$(playerctl -p spotify status 2>/dev/null)"  
# e.g. "Playing", "Paused", or "Stopped"

if [ "$status" = "Playing" ]; then
  artist_title="$(playerctl -p spotify metadata --format '  {{ artist }} - {{ title }}' 2>/dev/null)"
  echo "{\"text\": \"$artist_title\", \"class\": \"playing\"}"
elif [ "$status" = "Paused" ]; then
  artist_title="$(playerctl -p spotify metadata --format '  {{ artist }} - {{ title }}' 2>/dev/null)"
  echo "{\"text\": \"$artist_title\", \"class\": \"paused\"}"
else
  # Either "Stopped" or Spotify not running
  echo "{\"text\": \"No music for you my friend\", \"class\": \"stopped\"}"
fi
