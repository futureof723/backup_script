#!/usr/bin/env bash

# check to make sure user has entered exactly two arguments
if [ $# -ne 2 ]
then
  echo "Usage: $0 <source_directory> <target_directory>"
  echo "Please try again."
  exit 1
fi

# Check to see if rsync is available

if ! command -v rsync > /dev/null 2>&1
then
  echo "This script requires rsync to be installed."
  echo "Please user your distribution's package manager to install."
  exit 2
fi

# Capture the current date, and store it in the format YY-MM-DD
current_date=$(date +%Y-%m-%d)

# Backup directory
backup_dir="$2/$current_date"

# Ensure the backup directory exists if not create it
if [ ! -d "$backup_dir" ]
then
  mkdir -p "$backup_dir"
fi

# Ensure backup_script log directory exists if not create it
if [ ! -d /var/log/backup_script ]
then
  echo "Creating /var/log/backup_script"
  mkdir /var/log/backup_script
  echo "/var/log/backup_script created"
fi

# Perform the backup using rsync and log the output
$(which rsync) -avb --backup-dir="$backup_dir" --delete "$1" "$2/current" >> "/var/log/backup_script/backup_$current_date.log"