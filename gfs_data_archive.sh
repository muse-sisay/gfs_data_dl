#!/bin/bash

# Archives everything


NC_DIR="./NC_files"
ARCHIVE_DIR="${GFS_DIR}/ARCHIVED"

if [[ ! -d "${ARCHIVE_DIR}" ]]
then
	mkdir -p $ARCHIVE_DIR

fi

# Move to Download DIR
if [[ ! "$(pwd)" -ef "${GFS_DIR}/ICBC_GFS_data" ]]
then
	cd "${GFS_DIR}/ICBC_GFS_data"
fi

# Remove Nc directory
if [[ -d "${DATE}/${NC_DIR}" ]]
then
	rm -r "${DATE}/$NC_DIR"
fi

#
tar -zcvf "${ARCHIVE_DIR}/gfs_data_${DATE}.tar.gz" ${DATE}

#
rm -r  ${DATE}
