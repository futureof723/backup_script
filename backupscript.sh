#!/usr/bin/env bash

if [ $? -ne 2 ]
then
  echo "Usage: backup.sh <source_directory> <target_directory>"
  echo "Please try again."
  exit 1
fi



