#!/usr/bin/env bash

VERSION=0.2
MODE=$1

function special()
{
	youtube-dl -vv --external-downloader axel "$2" -o "$3";
}

function normal_mode()
{
 	youtube-dl -vv --external-downloader axel --external-downloader-args "-n $2 -a" "$3";
};

if [ "$MODE" == "--normal" ] || [ "$MODE" == "-n" ];
	then
	normal_mode "$@"
elif [ "$MODE" == "--special" ] || [ "$MODE" == "-s" ];
	then
	special "$@"
elif [ "$MODE" == "--help" ] || [ "$MODE" == "-h" ];
	then
	echo "Usage : download.sh [MODE] [URL]";
	echo "Modes:";
	echo "-n, --normal					Downloads file using axel with N number of connections";
	echo "(e.g download.sh -n [Number of connections] [URL])";
	echo "-s, --special 				Downloads the file then renames the downloaded file";
	echo "(e.g download.sh -s [URL] [Renamed file name])";
else
	echo "Usage : download.sh [MODE] [URL]";
fi 
