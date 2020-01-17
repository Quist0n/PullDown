#!/usr/bin/env bash

VERSION=0.6
MODE=$1

function normal_mode()
{
 	youtube-dl -vv --external-downloader axel --external-downloader-args "-n $2 -a" "$3" -o "$4";
};

function playlist()
{
	youtube-dl -vv --external-downloader axel --external-downloader-args "-n $2 -a" "$3" -o "%(autonumber)s - %(title)s.%(ext)s";
};

function single-con()
{
	youtube-dl -vv "$2" -o "$3";
};

function default_job() 
{
	youtube-dl -vv "$1";
}

if [ "$MODE" == "--normal" ] || [ "$MODE" == "-n" ]
	then
	normal_mode "$@";

elif [ "$MODE" == "--single-con" ] || [ "$MODE" == "-si" ];
	then
	single-con "$@";

elif [ "$MODE" == "--playlist" ] || [ "$MODE" == "-p" ];
	then 
	playlist "$@";

elif [ "$MODE" == "--help" ] || [ "$MODE" == "-h" ];
	then
	echo "Usage : $0 [MODE] [URL]";
	echo "Modes:";
	echo "-n | --normal					Downloads file using axel with N number of connections and writes file to [FILE]";
	echo "(e.g $0 -n [Number of connections] [URL] [FILE])";
	echo "-p | --playlist				Downloads a youtube playlist or other playlist supported by youtube-dl using axel to current working directory
	using N number of connections";
	echo "(e.g $0 -p [Number of connections] [URL])";
	echo "-sc | --single-con 				Downloads the file and writes it to [FILE], for use where multiple connections cannot be used";
	echo "(e.g $0 -sc [URL] [Renamed file name])";
else 	
	default_job "$@";
fi 
