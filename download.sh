#!/usr/bin/env bash

VERSION=0.6.4.1
MODE=$1

function normal_mode()
{
 	youtube-dl -vv --external-downloader axel --external-downloader-args "-n $2 -a" "$3" -o "$4";
};

function playlist()
{
	youtube-dl -vv --external-downloader axel --external-downloader-args "-n $2 -a" "$3" -o "%(autonumber)s-%(title)s.%(ext)s";
};

function single-con()
{
	youtube-dl -vv --hls-prefer-native "$2" -o "$3";
};

function default_job() 
{
	youtube-dl -vv "$1";
}

if [ "$MODE" == "--normal" ] || [ "$MODE" == "-n" ]
	then
	normal_mode "$@";

elif [ "$MODE" == "--single-con" ] || [ "$MODE" == "-s" ];
	then
	single-con "$@";

elif [ "$MODE" == "--playlist" ] || [ "$MODE" == "-p" ];
	then 
	playlist "$@";

elif [ "$MODE" == "--help" ] || [ "$MODE" == "-h" ];
	then
	echo "Usage : $0 [MODE] [URL]";
	echo "Invoking the script without a mode set will just invoke youtube-dl with debug output enabled pointed to download the url you
	specified. This can also allow you to pass youtube-dl options in, but this is untested, but SEEMS to work";
	echo "Modes:";
	echo "-n | --normal					Downloads file using axel with N number of connections and writes file to [FILE]";
	echo "(e.g $0 -n [Number of connections] [URL] [FILE])";
	echo "-p | --playlist				Downloads a youtube playlist or other playlist supported by youtube-dl using axel to current working directory
	using N number of connections";
	echo "(e.g $0 -p [Number of connections] [URL])";
	echo "-s | --single-con 				Downloads the file and writes it to [FILE], for use where multiple connections cannot be used";
	echo "(e.g $0 -sc [URL] [Renamed file name])";
	echo "";
	echo "If you are having an error in the script with youtube-dl unable to read the url, please surround it in quotes when you invoke the
	script.";
else 	
	default_job "$@";
fi 
