#!/usr/bin/env bash

VERSION=0.5
MODE=$1


function normal_mode()
{
 	youtube-dl -vv --external-downloader axel --external-downloader-args "-n $2 -a" "$3" -o "$4";
};

function playlist()
{
		youtube-dl -vv --external-downloader axel --external-downloader-args "-n $2 -a" "$3" -o "%(autonumber)s - %(title)s.%(ext)s";
};

output_det=0;
function generic()
{
	if [ $output_det == 0 ];
	then
		youtube-dl -vv "$2" -o "$3";
	else
		youtube-dl -vv "$2";
	fi
};


if [ "$MODE" == "--normal" ] || [ "$MODE" == "-n" ]
	then
	normal_mode "$@";
elif [ "$MODE" == "--generic" ] || [ "$MODE" == "-g" ];
	then
	generic "$@";
elif [ "$MODE" == "--playlist" ] || [ "$MODE" == "-p" ];
	then 
	playlist "$@";
elif [ -z "$MODE" ];
	then 
	output_det=1;
	generic "$@";
elif [ "$MODE" == "--help" ] || [ "$MODE" == "-h" ];
	then
	echo "Usage : $0 [MODE] [URL]";
	echo "Modes:";
	echo "-n | --normal					Downloads file using axel with N number of connections and writes file to [FILE]";
	echo "(e.g $0 -n [Number of connections] [URL] [FILE])";
	echo "-p | --playlist				Downloads a youtube playlist or other playlist supported by youtube-dl using axel to current working directory
	using N number of connections";
	echo "(e.g $0 -p [Number of connections] [URL])";
	echo "-g | --generic 				Downloads the file and writes it to [FILE], for use where multiple connections cannot be used";
	echo "(e.g $0 -g [URL] [Renamed file name])";
	echo "-g | --generic also can be invoked without [Remaned file name] and will default to the file name on the server" 

else
	echo "Usage : $0 [MODE] [URL]";
	echo "Use $0 [-h|--help] for options";
fi 
