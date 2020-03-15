#!/bin/bash

GFS_DIR=$(pwd)
export $GFS_DIR

# Start the downloader script
${GFS_DIR}/gfs_data_downloader.sh

# Start the nc Extractor
${GFS_DIR}/gfs_data_extractor.sh
