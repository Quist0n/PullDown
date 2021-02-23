#!/bin/bash

VERSION=0.8.0
NAME='pulldown.sh'
OUTPUT_FORMAT_PLAYLIST='%(autonumber)s-%(title)s.%(ext)s'
OUTPUT_FORMAT_NORMAL='%(title)s.%(ext)s'
#Some default flags to pass no matter what
ARGS="-v"
URLS=""
YTDL_ARGS=""

usage()
{
        while read; do
                printf "%s\n" "$REPLY"
        done <<-EOF
Usage : $NAME [MODE] URL [OPTIONS]
Modes:
        -n | --normal
        Downloads file giving the file its name via the template '$OUTPUT_FORMAT_NORMAL'
        (e.g $NAME -n  [URL] [OPTIONS])

        -p | --playlist
        Downloads a youtube playlist or other playlist supported by youtube-dl to current working directory using template '$OUTPUT_FORMAT_PLAYLIST'
        (e.g $NAME -p URL [OPTIONS])

        -a | --audio
        Downloads audio only.
        (e.g $NAME -a URL [OPTIONS])

        -s | --hls | --native-hls
        Downloads the file with the youtube-dl native HLS downloader
        (e.g $NAME -s URL [OPTIONS])

        -m | --metadata
        Add metadata to the file
        (e.g $NAME -m URL [OPTIONS])
        If you are having an error in the script with youtube-dl unable to read the url, please surround it in quotes when you invoke the script.
EOF
}
while [ "$1" ]; do
        case "$1" in
                --normal | -n)
                        ARGS="${ARGS} -o "$OUTPUT_FORMAT_NORMAL" " ;;
                --hls | -s)
                        ARGS="${ARGS} --hls-prefer-native " ;;
                --playlist | -p)
                        ARGS="${ARGS} -o "$OUTPUT_FORMAT_PLAYLIST" " ;;
                --audio | -a)
                        ARGS="${ARGS} -x " ;;
                --metadata | -m)
                        ARGS="${ARGS} --add-metadata " ;;
                --help | -h)
                         usage; exit ;;
                http*://*)
                        URLS="${URLS} $1 " ;;
                *)
                        YTDL_ARGS="${YTDL_ARGS} $1 " ;;
        esac
        shift
done

if [ -z "$URLS" ]; then
        printf "Please specify a url to act upon (E.g https://example.com/video.mp4)\n"; exit 1
else
        youtube-dl $ARGS $URLS $YTDL_ARGS;
fi
