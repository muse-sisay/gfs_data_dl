#!/bin/bash

# LOCATION
LEFT_LON=32
RIGHT_LON=52
TOP_LAT=17
BOTTOM_LAT=0

export LEFT_LON RIGHT_LON TOP_LAT BOTTOM_LAT


# GFS Direcotry
GFS_DIR=$(pwd)
# The date that the gfs data should be downloaded for 
# change to any date wanted, Format ( yyyymmdd )
DATE=$(date +%Y%m%d)

export GFS_DIR
export DATE

# Start the downloader script
${GFS_DIR}/gfs_data_downloader.sh

# Start the nc Extractor
${GFS_DIR}/gfs_data_extractor.sh


# Perform Archival
${GFS_DIR}/gfs_data_archive.sh
