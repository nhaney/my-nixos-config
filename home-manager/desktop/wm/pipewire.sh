#!/bin/sh

function main() {
    if [ $# -ge 1 ] && [ -n "$1" ]
    then
        case $1 in
            "up")
                pamixer --increase 10
                ;;
            "down")
                pamixer --decrease 10
                ;;
            "mute")
                pamixer --toggle-mute
                ;;
            "control")
                pavucontrol
                ;;
        esac
    else
	volume=$(pamixer --get-volume-human)

	# Check if the volume is muted
	if [[ $volume == "muted" ]]; then
	    emoji="🔇"  # Muted
	else
	    # Extract the numeric volume value from the output
	    volume_number=$(echo "$volume" | grep -oE '[0-9]+')

	    # Define the emoji based on volume level
	    if [ "$volume_number" -eq 0 ]; then
		emoji="🔈"  # Muted
	    elif [ "$volume_number" -lt 30 ]; then
		emoji="🔈"  # Low volume
	    elif [ "$volume_number" -lt 70 ]; then
		emoji="🔉"  # Medium volume
	    else
		emoji="🔊"  # High volume
	    fi
	fi
	echo "$emoji"
    fi
}

main "$@"
