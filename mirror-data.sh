#!/bin/bash

# This script is for mirroring directories
#
# Author: Joerg Sorge
# Distributed under the terms of GNU GPL version 2 or later
# Copyright (C) Joerg Sorge joergsorge at gmail.com
# 2018-06-20

# config for mirror
# log directories
path_log="/home/myname/mirror-data/log/"
# logfile, full path for correct writing with cron
path_file_log="/home/myname/mirror-data/log/mirror-data.log"
# source folders
# sourchpaths array items, don't forget the numbering
a_sourcepath[0]="/home/myname/mydata0"
a_sourcepath[1]="/home/myname/mydata1"

# destination folders
# changing a to b from day to day if even or odd
# this folders also used to check, if the drive is available
# it's necessary to notice in the dir path at least one more depth
# to avoid a false positive by the check of availability of the mount
# (the mount point itself could exist, even when it's not mounted)
mirrorpath_a="/home/myname/mount/mirror-data_a/"
mirrorpath_b="/home/myname/mount/mirror-data_b/"

# mountz
# check if dir is available (Y or N)
mount_check="Y"

# do not edit below this line
mount_available="N"

function f_check_dir () {
	echo "Check if mount is available..."
	if [ -d "$1" ]; then
			mount_available="Y"
			echo "Available: $1"
			echo "Available: $1" >> $path_file_log
	else
		echo "Not available: $1"
		echo "$1 not available" >> $path_file_log
	fi
}

function f_check_dir_log () {
	echo "Check if log dir exists..."
	if [ -d "$1" ]; then
			echo "It's available."
			echo "" >> $path_file_log
			echo "Available: $1" >> $path_file_log
	else
		echo "Creating: $1"
		mkdir "$1"
		echo "" >> $path_file_log
		echo "Created: $1" >> $path_file_log
	fi
}

running=$(date +'%Y-%m-%d-%H-%M-%S')
dates=$(date +'%d')
echo "$running running mirror-data.sh..."
f_check_dir_log "$path_log"

echo "" >> $path_file_log
echo "$running running mirror-data.sh..." >> $path_file_log
if [ $((10#${dates}%2)) -eq 0 ]; then
	echo "Syncing to $mirrorpath_a"
	echo "Syncing to $mirrorpath_a" >> $path_file_log
	mirrorpath=$mirrorpath_a
else
	echo "Syncing to $mirrorpath_b"
	echo "Syncing to $mirrorpath_b" >> $path_file_log
	mirrorpath=$mirrorpath_b
fi

if [ $mount_check == "Y" ]; then
	f_check_dir "$mirrorpath"
else
	mount_available="Y"
fi

if [ $mount_available == "Y" ]; then

	for c_dir in "${a_sourcepath[@]}"
	do
	  echo " ------------------"
	  echo "Syncing mirror from ${c_dir}"
	  echo " ------------------" >> $path_file_log
	  echo "Syncing mirror from ${c_dir}" >> $path_file_log
	  rsync -r -t -v -s --delete --log-file=$path_file_log $c_dir $mirrorpath
	done
else
	echo "No mirror-syncing possible" >> $path_file_log
fi
running=$(date +'%Y-%m-%d-%H-%M-%S')
echo "$running finish"
echo "$running finish" >> $path_file_log
exit
