#!/usr/bin/env bash

set -e
syntax='Usage: minecraft_backup_cleanup.sh [OPTION]'

max_number_of_backups=2

############
## TODO
# Add max copies parameter option
# get list for different worlds
# remove
# dry run option
############


args=$(getopt -l backup-dir:,help -o b:h -- "$@") || exit
eval set -- "$args"
while [ "$1"  != -- ]; do
	case $1 in
	--backup-dir|-b)
		backup_dir=$2
		shift 2
		;;
	--help|-h)
		echo "$syntax"
		echo Clean up backup files for Minecraft.
		echo
		echo Optional arguments:
		echo '-b, --backup-dir=BACKUP_DIR  directory backups go in. defaults to ~.'
		echo
		echo 'Backups should be in the format {WORLD}_Backup-{YEAR}_{MONTH}_{DATE}_{TIME}.zip in BACKUP_DIR.'
		exit
		;;
	esac
done
shift

if [ "$#" -gt 0 ]; then
	>&2 echo Too many arguments
	>&2 echo "$syntax"
	exit 1
fi


if [ -n "$backup_dir" ]; then
	backup_dir=$(realpath "$backup_dir")
else
	backup_dir=~
fi

echo BACKUP_DIR: $backup_dir

cd $backup_dir

files=($(ls | egrep -i '.*._Backup-[0-9][0-9][0-9][0-9]_[0-1][0-9]_[0-3][0-9]_[0-9][0-9]-[0-9][0-9].zip' | sort -r))
files_to_remove=(${files[@]:$max_number_of_backups})
file_count=${#files[@]}

if [ "$files_to_remove" == "" ]; then
	files_to_remove_count=0
	else
	files_to_remove_count=${#files_to_remove[@]}
fi

files_after_cleanup_count=$((file_count - files_to_remove_count))

if [ $file_count -le $max_number_of_backups ]; then
	echo There there are already too few backups to clean up. Clean up SUCCESS!
	exit
	elif [ $files_after_cleanup_count -ne $max_number_of_backups ]; then
	>&2 echo Something went horribly wrong. The remaining files after cleanup would of been less that what is configured. Clean up CANCELLED!
	exit 1
fi

echo "Current files in the directory: ${files[*]}"
echo "Removing the following files: ${files_to_remove[*]}"