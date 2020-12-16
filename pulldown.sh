#!/bin/bash

VERSION=0.6.5.1
MODE=$1

function normal_mode()
{
 	youtube-dl -v  --external-downloader axel "$1" -o "$2";
};

function playlist()
{
	youtube-dl -v "$1" -o "%(autonumber)s-%(title)s.%(ext)s";
};

function native_hls()
{
	youtube-dl -v --hls-prefer-native "$1" -o "$2";
};

function default_job() 
{
	youtube-dl -v "$@";
}

if [ "$MODE" == "--normal" ] || [ "$MODE" == "-n" ]
	then
	normal_mode "$2" "$3";

elif [ "$MODE" == "--native-hls" ] || [ "$MODE" == "-s" ] || [ "$MODE" == "-hls" ];
	then
	native_hls "$2" "$3";

elif [ "$MODE" == "--playlist" ] || [ "$MODE" == "-p" ];
	then 
	playlist "$2";

elif [ "$MODE" == "--help" ] || [ "$MODE" == "-h" ];
	then
	echo "Usage : $0 [MODE] URL [FILE]";
	echo "Invoking the script without a mode set will just invoke youtube-dl with debug output enabled pointed to download the url you
	specified. This can also allow you to pass youtube-dl options in, but this is untested, but SEEMS to work";
	echo "Modes:";
	echo "-n | --normal					Downloads file using axel directed to to [FILE] or the default file name";
	echo "(e.g $0 -n  [URL] [FILE])";
	echo "-p | --playlist				Downloads a youtube playlist or other playlist supported by youtube-dl to current working directory";
	echo "(e.g $0 -p [URL])";
	echo "-s | -hls |--native-hls 				Downloads the file and writes it to [FILE] or the default file name, for use where the axel
    downloader cannot be used";
	echo "(e.g $0 -sc [URL] [Renamed file name])";
	echo "";
	echo "If you are having an error in the script with youtube-dl unable to read the url, please surround it in quotes when you invoke the
	script.";
else 	
	default_job "$@";
fi 
