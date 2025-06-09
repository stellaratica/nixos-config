#!/usr/bin/env bash

playerctl_status=$(playerctl status 2>&1)

if [ "$playerctl_status" = "No players found" ]; then
    exit 1
fi

mpris_player_name=$(playerctl metadata -f "{{playerName}}")

if [ "$playerctl_status" = "Paused" ]; then
    media_icon="󰏤"
else
    case $mpris_player_name in
        spotify)
	    media_icon="󰓇"
	    ;;
        firefox)
	    media_icon="󰗃"
	    ;;
	*)
	    media_icon="󰝚"
	    ;;
    esac
fi

echo "${media_icon} $(playerctl metadata -f "{{title}} - {{artist}}")"
