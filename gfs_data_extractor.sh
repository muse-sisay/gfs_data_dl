#!/bin/bash

# GFS Extractor

DATE=$(date +%Y%m%d)

# Move to todays DIR
if [[ "$(pwd)" -ne "$GFS_DIR/${DATE}" ]]
then
	cd $GFS_DIR
fi

NC_DIR="./NC_files"

if [[ !  -d $NC_DIR ]]
then
	mdkir  $NC_DIR
fi

HR=00
BEGIN_FHR=0

for END_FHR in {000..384..6}
do

	# Downloaded File
	IN_FILE="gfs.t${HR}.pgrb2.0p25.f${END_FHR}"

	# Output file in .nc format
	OUT_FILE="${NC_DIR}/total_wrf_rf_f${END_FHR}.nc"
	OUT_FILE_CONV_RF="${NC_DIR}/conv_wrf_rf_f${END_FHR}.nc"
	OUT_FILE_TMAX="${NC_DIR}/wrf_tmax_f${END_FHR}.nc"
	OUT_FILE_TMIN="${NC_DIR}/wrf_tmin_f${END_FHR}.nc"
	OUT_FILE_CPRAT="${NC_DIR}/wrf_cprat_f${END_FHR}.nc"
	OUT_FILE_PRATE="${NC_DIR}/wrf_prate_f{END_FHR}.nc"
	OUT_FILE_WATR="${NC_DIR}/wrf_watr_f{END_FHR}.nc"
	OUT_FILE_VFLX="${NC_DIR}/wrf_vflx_f{END_FHR}.nc"
	OUT_FILE_UFLX="${NC_DIR}/wrf_uflx_f{END_FHR}.nc"
	OUT_FILE_TMP_LC="${NC_DIR}/wrf_Tmp_LC_f${END_FHR}.nc"
	OUT_FILE_TMP_MC="${NC_DIR}/wrf_Tmp_MC_f${END_FHR}.nc"
	OUT_FILE_TMP_HC="${NC_DIR}/wrf_Tmp_HC_f${END_FHR}.nc"
	OUT_FILE_USWRF="${NC_DIR}/wrf_uswrfsur_f${END_FHR}.nc"
	OUT_FILE_ULWRF="${NC_DIR}/wrf_ulwrfsur_f${END_FHR}.nc"
	OUT_FILE_USWRF_TATM="${NC_DIR}/wrf_uswrfatm_f${END_FHR}.nc"
	OUT_FILE_UGRD="${NC_DIR}/wrf_more_f${END_FHR}.nc"

	#
	wgrib2 $FILE -s | egrep '(:APCP:surface:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE

	# Convective rainfall
	wgrib2 $FILE -s | egrep '(:ACPCP:surface:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_CONV_RF

	# Tmax
	wgrib2 $FILE -s | egrep '(:TMAX:2 m above ground:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_TMAX

	# Tmin
	wgrib2 $FILE -s | egrep '(:TMIN:2 m above ground:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_TMIN

	# CPRAT
	wgrib2 $FILE -s | egrep '(:CPRAT:surface:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_CPRAT

	# PRATE
	wgrib2 $FILE -s | egrep '(:PRATE:surface:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_PRATE
	
	# WATR
	wgrib2 $FILE -s | egrep '(:WATR:surface:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_WATR

	# VFLX
	wgrib2 $FILE -s | egrep '(:VFLX:surface:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_VFLX

	# UFLX
	wgrib2 $FILE -s | egrep '(:UFLX:surface:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_UFLX

	# TMP Low cloud
	wgrib2 $FILE -s | egrep '(:TMP:low cloud top level:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_TMP_LC

	# TMP middle cloud
	wgrib2 $FILE -s | egrep '(:TMP:middle cloud top level:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_TMP_MC

	# TMP  high cloud
	wgrib2 $FILE -s | egrep '(:TMP:high cloud top level:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_TMP_HC

	# USWRF
	wgrib2 $FILE -s | egrep '(:USWRF:surface:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_USWRF

	# ULWRF
	wgrib2 $FILE -s | egrep '(:ULWRF:surface:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_ULWRF

	# USWRF top  atmosphere
	wgrib2 $FILE -s | egrep '(:USWRF:top of atmosphere:${BEGIN_FHR}-${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_USWRF_TATM

	# UGRD
	wgrib2 $FILE -s | egrep '(:UGRD:1000 mb:${END_FHR}|:VGRD:1000 mb:${END_FHR}|:UGRD:850 mb:${END_FHR}|:VGRD:850 mb:${END_FHR}|:UGRD:250 mb:${END_FHR}|:VGRD:250 mb:${END_FHR}|:UGRD:500 mb:${END_FHR}|:VGRD:500 mb:${END_FHR}|:UGRD:200 mb:${END_FHR}|:VGRD:200 mb:${END_FHR}|:UGRD:700 mb:${END_FHR}|:VGRD:700 mb:${END_FHR}|:RH:1000 mb:${END_FHR}|:RH:850 mb:${END_FHR}|RH:250 mb:${END_FHR}|:RH:700 mb:${END_FHR}|:RH:500 mb:${END_FHR}|:RH:200 mb:${END_FHR}|:RH:entire atmosphere (considered as a single layer):${END_FHR}|:RH:highest tropospheric freezing level:${END_FHR}|:PRMSL:mean sea level:${END_FHR}|:RH:highest tropospheric freezing level:${END_FHR}|:HGT:highest tropospheric freezing level:${END_FHR}|:UGRD:max wind:${END_FHR}|:VGRD:max wind:${END_FHR}|:CWAT:entire atmosphere (considered as a single layer):${END_FHR}|:DZDT:1000 mb:${END_FHR}|:DZDT:850 mb:${END_FHR}|:DZDT:500 mb:${END_FHR}|:DZDT:250 mb:${END_FHR}|:DZDT:200 mb:${END_FHR}|:VIS:surface:${END_FHR}|:UGRD:planetary boundary layer:${END_FHR}|:VGRD:planetary boundary layer:${END_FHR}|:GUST:surface:${END_FHR}|:TSOIL:0-0.1 m below ground:${END_FHR}|:SOILW:0-0.1 m below ground:${END_FHR}|:TSOIL:0.1-0.4 m below ground:${END_FHR}|:SOILW:0.1-0.4 m below ground:${END_FHR}|:TSOIL:0.4-1 m below ground:${END_FHR}|:SOILW:0.4-1 m below ground:${END_FHR}|:TSOIL:1-2 m below ground:${END_FHR}|:SOILW:1-2 m below ground:${END_FHR}|:WEASD:surface:${END_FHR}|:PEVPR:surface:${END_FHR}|:TMP:2 m above ground:${END_FHR}|:RH:2 m above ground:${END_FHR})' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE_UGRD


	if [[  $(( $END_FHR % 24)) -eq 0 ]]
	then 
		DAY=$(( $END_FHR /24))
		OUT_FILE="total_wrf_rf_d_0${DAY}.nc"
		wgrib2 $FILE -s | egrep '(:APCP:surface:0-${DAY} day)' | wgrib2 -i $IN_FILE -netcdf  $OUT_FILE	
	fi

	BEGIN_HR=$END_FHR

done
