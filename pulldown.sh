#!/bin/bash

VERSION=0.6.5.3
MODE=$1
NAME="pulldown.sh"
OUTPUT_FORMAT="%(autonumber)s-%(title)s.%(ext)s"

function normal_mode()
{
        [ "$2" == "" ] && youtube-dl -v --add-metadata --external-downloader axel "$1" -o $OUTPUT_FORMAT && exit;
        [ "$2" != "" ] && youtube-dl -v --add-metadata --external-downloader axel "$1" -o "$2.%(ext)s" && exit;
};

function playlist()
{
	youtube-dl -v "${@:2}" --add-metadata "$1" -o $OUTPUT_FORMAT;
};

function audio_job()
{
        youtube-dl -v -x "${@:2}" --add-metadata "$1" -o $OUTPUT_FORMAT;
};

function native_hls()
{
        [ "$2" == "" ] && youtube-dl -v --add-metadata --hls-prefer-native "$1" -o $OUTPUT_FORMAT && exit;
        [ "$2" != "" ] && youtube-dl -v --add-metadata --hls-prefer-native "$1" -o "$2.%(ext)s" && exit;
};

function default_job() 
{
	youtube-dl -v "$@";
};


if [ "$MODE" == "--normal" ] || [ "$MODE" == "-n" ]
	then
	normal_mode "$2" "$3";

elif [ "$MODE" == "--native-hls" ] || [ "$MODE" == "-s" ] || [ "$MODE" == "--hls" ];
	then
	native_hls "$2" "$3";

elif [ "$MODE" == "--playlist" ] || [ "$MODE" == "-p" ];
	then 
	playlist "$2" "${@:3}";
elif [ "$MODE" == "--audio" ] || [ "$MODE" == "-a" ];
    then
    audio_job "$2" "${@:3}";
elif [ "$MODE" == "--help" ] || [ "$MODE" == "-h" ];
	then
    echo "PullDown $VERSION";
	echo "Usage : $NAME [MODE] URL [FILE]";
	echo "Invoking the script without a mode set will just invoke youtube-dl with debug output enabled pointed to download the url you
	specified. This can also allow you to pass youtube-dl
    options in, but this is untested, but SEEMS to work.";

	echo "Modes:";
	echo "-n | --normal					Downloads file using axel directed to [FILE] or the default file name";
	echo "(e.g $NAME -n  [URL] [FILE])";

	echo "-p | --playlist				Downloads a youtube playlist or other playlist supported by youtube-dl to current working directory
    with a output format set to number all downloads. You can pass youtube-dl options to this mode but don't use -o in your options as it would
    conflict with the -o already used";
	echo "(e.g $NAME -p URL [OPTIONS])";

	echo "-a | --audio				Downloads audio to current working directory
    with a output format set to number all downloads. You can pass youtube-dl options to this mode but don't use -o in your options as it would
    conflict with the -o already used. This one is almost the
    same as the playlist mode but simply prevents video from
    being downloaded.";
    echo "(e.g $NAME -a URL [OPTIONS])"

	echo "-s | --hls |--native-hls 				Downloads the file and writes it to [FILE] or the default file name, for use where the axel
    downloader cannot be used";
	echo "(e.g $NAME -s URL [FILE])";

	echo "If you are having an error in the script with youtube-dl unable to read the url, please surround it in quotes when you invoke the
	script.";
else 	
	default_job "${@:2}";
fi 
