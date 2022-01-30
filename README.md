# Pulldown
Bash script to make it easier to use youtube-dl or youtube-dl forks.

# Usage:
        --help | -h ) Prints out the basic help

        --normal | -n ) This will make Pulldown use a basic template
        using the title of the file followed by its
        extension for saving the file to disk.

        --hls | -s ) This will make Pulldown tell youtube-dl use its in-built HLS         support

        --playlist | -p ) This will make Pulldown use a zero-padded
        number for outputing playlists. This allows for you to
        download an entire playlist and number them appropriately to
        preserve the order. It also appends the extension to the end
        of the filename similar to --normal

        --audio | -a ) This will make Pulldown exclusively fetch audio

        --metadata | -m ) If there is metadata available for the file
        being downloaded, it will be preserved.

# NOTICE

Currently specifying options as a single flag (e.g -ams ) does not work
and each option must be specified seperately (e.g -a -m -s)
