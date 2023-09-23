#!/bin/bash
YTDL="/bin/yt-dlp"
VERSION=0.8.6
NAME='pulldown.sh'
OUTPUT_FORMAT_NORMAL='%(title)s.%(ext)s'
OUTPUT_FORMAT_PLAYLIST='%(playlist_autonumber)s-%(title)s.%(ext)s'
#Some default flags to pass no matter what
ARGS="-v --restrict-filenames"
YTDL_ARGS=""

usage()
{
        cat <<- _end_help
Usage : $NAME [MODE] [OPTIONS]
Modes:
        -n | --normal
        Download using a standard file naming template template '$OUTPUT_FORMAT_NORMAL'
        (e.g $NAME -n [OPTIONS])

        -p | --playlist
        Download playlists using the output template '$OUTPUT_FORMAT_PLAYLIST'
        (e.g $NAME -p [OPTIONS])

        -a | --audio
        Downloads audio only.
        (e.g $NAME -a [OPTIONS])

        -s | --hls | --native-hls
        Downloads the file with the youtube-dl native HLS downloader
        (e.g $NAME -s [OPTIONS])

        -m | --metadata
        Add metadata to the file
        (e.g $NAME -m [OPTIONS])

        If you are having an error in the script with youtube-dl unable to read the url, please surround it in quotes when you invoke the script.
_end_help
}
while [ "$1" ]; do
        case "$1" in
                --normal | -n)
                        ARGS="${ARGS} -o "$OUTPUT_FORMAT_NORMAL" " ;;
                --playlist | -p)
                        ARGS="${ARGS} -o "$OUTPUT_FORMAT_PLAYLIST" " ;;
                --hls | -s)
                        ARGS="${ARGS} --hls-prefer-native " ;;
                --audio | -a)
                        ARGS="${ARGS} -x " ;;
                --metadata | -m)
                        ARGS="${ARGS} --add-metadata " ;;
                --help | -h)
                         usage; exit ;;
                *)
                        YTDL_ARGS="${YTDL_ARGS} $1 " ;;
        esac
        shift
done

$YTDL $ARGS $YTDL_ARGS;
