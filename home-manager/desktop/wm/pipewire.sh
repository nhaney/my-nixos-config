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
        VOLUME=$(pamixer --get-volume-human)
        echo "${VOLUME}"
    fi
}

main "$@"
