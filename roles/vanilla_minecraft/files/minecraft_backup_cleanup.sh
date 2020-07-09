#!/usr/bin/env bash

set -e
syntax='Usage: minecraft_backup_cleanup.sh [OPTION]'

max_number_of_backups=3

args=$(getopt -l backup-dir:,level-name:,dry-run,help -o b:l:n:h -- "$@") || exit
eval set -- "$args"
while [ "$1"  != -- ]; do
	case $1 in
	--backup-dir|-b)
		backup_dir=$2
		shift 2
		;;
	--level-name|-l)
		level_name=$2
		shift 2
		;;
	-n)
	max_number_of_backups=$2
	shift 2
	;;
	--dry-run)
		dry_run=true
		shift 1
		;;
	--help|-h)
		echo "$syntax"
		echo "Clean up backup files for Minecraft."
		echo
		echo "Optional arguments:"
		echo "-b, --backup-dir=BACKUP_DIR  directory backups go in (defaults to ~)."
		echo "-l  --level-name=LEVEL_NAME  level name of the backups (defaults to *)."
		echo "-n                           number of backups to keep (defaults to 3)."
		echo "--dry-run"
		echo
		echo "Backups should be in the format {WORLD}_Backup-{YEAR}_{MONTH}_{DATE}_{TIME}.zip in BACKUP_DIR."
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

if [ -z "$level_name" ]; then
	level_name=*
fi

success_message() {
	echo
	echo "Cleanup ran sucessfully."
	echo
}

echo
echo "#########################################"
echo "Minecraft server backup cleanup tool"
echo "#########################################"
echo

echo "BACKUP_DIR: $backup_dir"
echo "Maximum number of backups: $max_number_of_backups"

cd $backup_dir

for file in ${level_name}_Backup-[0-9][0-9][0-9][0-9]_[0-1][0-9]_[0-3][0-9]_[0-9][0-9]-[0-9][0-9].zip; do
	if ! [ "$file" == "${level_name}_Backup-[0-9][0-9][0-9][0-9]_[0-1][0-9]_[0-3][0-9]_[0-9][0-9]-[0-9][0-9].zip" ]; then
		unsorted_files+=($file)
	fi
done

IFS=$'\n' files=($(sort -r <<<"${unsorted_files[*]}")); unset IFS

echo "Current files in the directory: ${files[*]}"
echo

files_to_remove=(${files[@]:$max_number_of_backups})
file_count=${#files[@]}

if [ "$files_to_remove" == "" ]; then
	files_to_remove_count=0
	else
	files_to_remove_count=${#files_to_remove[@]}
fi

files_after_cleanup_count=$((file_count - files_to_remove_count))

if [ $file_count -le $max_number_of_backups ]; then
	echo "There there are already too few backups to clean up."
	success_message
	exit
	elif [ $files_after_cleanup_count -ne $max_number_of_backups ]; then
	>&2 echo "Something went horribly wrong. The remaining files after cleanup would of been less that what is configured. Cleanup CANCELLED!"
	exit 1
fi

for file in ${files_to_remove[*]}; do
	if [ "$dry_run" = true ]; then
		echo "DRY RUN -> Removed $file"
	else
		rm -f $file
		echo "Removed $file"
	fi
done

success_message
exit