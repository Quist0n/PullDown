#!/usr/bin/env bash

VERSION=0.1
MODE=$1

function special()
{
	youtube-dl -v --external-downloader axel "$2"; mv "$3" "$4";
}

function normal_mode()
{
 	youtube-dl -v --external-downloader axel --external-downloader-args "-n $2 -a" "$3";
};

if [ "$MODE" == "--normal" ] || [ "$MODE" == "-n" ];
	then
	normal_mode "$@"
elif [ "$MODE" == "--special" ] || [ "$MODE" == "-s" ];
	then
	special "$@"
elif [ "$MODE" == "--help" ]	|| [ "$MODE" == "-h" ];
	then
	echo "Usage : download.sh [MODE] [URL]";
	echo "Modes:";
	echo "-n, --normal					Downloads file using axel with N number of connections";
	echo "(e.g download.sh -n [Number of connections] [URL])";
	echo "-s, --special 				Downloads the file then renames the downloaded file";
	echo "(e.g download.sh -s [URL] [Original file name ] [Renamed file name])"
else
	echo "Usage : download.sh [MODE] [URL]";
fi 
