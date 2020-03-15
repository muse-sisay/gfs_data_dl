#!/bin/bash

GFS_DIR=$(pwd)
DATE=$(date +%Y%m%d)

export GFS_DIR
export DATE

# Start the downloader script
${GFS_DIR}/gfs_data_downloader.sh

# Start the nc Extractor
${GFS_DIR}/gfs_data_extractor.sh
