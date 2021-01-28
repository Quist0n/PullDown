#!/bin/bash

VERSION=0.7.1
MODE=$1
NAME="pulldown.sh"
OUTPUT_FORMAT_PLAYLIST="\%\(autonumber\)s-\%\(title\)s.\%\(ext\)s"
OUTPUT_FORMAT_NORMAL="\%\(title\)s.\%\(ext\)s"
ARGS="-v --add-metadata "
EXTRA_ARGS="${@:3}"

if [ "$MODE" == "--normal" ] || [[ "$MODE" == "-"*"n"* ]];
	then
    ARGS="${ARGS} -o $OUTPUT_FORMAT_NORMAL"; 
fi

if [ "$MODE" == "--native-hls" ] || [[ "$MODE" == "-"*"s"* ]] || [ "$MODE" == "--hls" ];
	then
    ARGS="${ARGS} --hls-prefer-native ";
fi

if [ "$MODE" == "--playlist" ] || [[ "$MODE" == "-p"* ]] || [[ "$MODE" == *"p" ]];
	then 
    ARGS="${ARGS} -o $OUTPUT_FORMAT_PLAYLIST ";
fi

if [ "$MODE" == "--audio" ] || [[ "$MODE" == "-"*"a"* ]];
    then
    ARGS="${ARGS} -x ";
fi

if [ "$MODE" == "--help" ] || [ "$MODE" == "-h" ];
	then
    echo -e "PullDown $VERSION";
	echo -e "Usage : $NAME [MODE] URL [OPTIONS]";

	echo -e "Modes:";

	echo -e "-n | --normal\n\tDownloads file giving the file its name via the template $OUTPUT_FORMAT_NORMAL variable";
	echo -e "(e.g $NAME -n  [URL] [OPTIONS])";

	echo -e "-p | --playlist\n\tDownloads a youtube playlist or other playlist supported by youtube-dl to current working directory using template $OUTPUT_FORMAT_PLAYLIST";
	echo -e "(e.g $NAME -p URL [OPTIONS])";

	echo -e "-a | --audio\n\tDownloads audio only.";
    echo -e "(e.g $NAME -a URL [OPTIONS])"

	echo -e "-s | --hls |--native-hls\n\tDownloads the file with the youtube-dl native HLS downloader";
	echo -e "(e.g $NAME -s URL [OPTIONS])";

	echo -e "If you are having an error in the script with youtube-dl unable to read the url, please surround it in quotes when you invoke the
	script.";
    exit;
fi 

eval "youtube-dl $ARGS $2 $EXTRA_ARGS";
