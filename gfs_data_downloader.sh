#!/bin/bash
#
# GFs Downloader
# Hourly Grib Data Downloader
# TO DO LIST : log file

DATE=$(date +%Y%m%d)

# Download Directory
DIR="{GFS_DIR}/ICBC_GFS_data/${DATE}"

# Location (long, latt )
LEFT_LON=32
RIGHT_LON=52
TOP_LAT=17
BOTTOM_LAT=0

# URL parameters
FILTER="https://nomads.ncep.noaa.gov/cgi-bin/filter_gfs_0p25.pl"
OPTION="all_lev=on&var_ACPCP=on&var_APCP=on&var_CAPE=on&var_CPRAT=on&var_CWAT=on&var_DZDT=on&var_FLDCP=on&var_GUST=on&var_HGT=on&var_HPBL=on&var_LFTX=on&var_PEVPR=on&var_PLPL=on&var_PRATE=on&var_PRMSL=on&var_RH=on&var_SOILW=on&var_SUNSD=on&var_TMAX=on&var_TMIN=on&var_TMP=on&var_TSOIL=on&var_UFLX=on&var_UGRD=on&var_ULWRF=on&var_USTM=on&var_USWRF=on&var_VFLX=on&var_VGRD=on&var_VIS=on&var_VSTM=on&var_VWSH=on&var_WATR=on&var_WEASD=on&var_WILT=on"
LOCATION="subregion=&leftlon=${LEFT_LON}&rightlon=${RIGHT_LON}&toplat=${TOP_LAT}&bottomlat=${BOTTOM_LAT}"

HR=00   # is this necessary

LOG_FILE="gfs.${DATE}.log"

if [[ ! -d $DIR  ]]
then
	mkdir -p $DIR
fi

# Move to the DL directory
cd $DIR

if [[ ! -a $LOG_FILE ]]
then
	touch $LOG_FILE
fi

# For the next 16 days download forcast data every 6 hours
for fhr in {000..384..6}
do

	# Additonal URL parameter
	FILE="file=gfs.t${HR}z.pgrb2.0p25.f${fhr}"
	FILE_DIR="dir=%2Fgfs.${DATE}%2F${HR}"

	# Construct URL
	URL="${FILTER}?${FILE}&${OPTION}&${LOCATION}&${FILE_DIR}"

	OUTPUT="gfs.t${hr}.pgrb2.0p25.f${fhr}"

	cat $LOG_FILE | grep $OUTPUT
	# Checking if the file is already downloaded

	if [[ "$?" -eq 1  ]] # File is not on the log
	then

		# Delete the file, i.e the unfinished download
		if [[ -a $OUTPUT ]]
		then
			rm $OUTPUT
		fi

		# Download the grib file using curl
		/usr/bin/curl "$URL" -o "$OUTPUT" && echo "$OUTPUT" >> $LOG_FILE
	fi

done

exit 0
