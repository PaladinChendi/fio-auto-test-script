#!/usr/bin/env bash

iops_result=$(grep -o 'IOPS=[0-9\ \.]*[km]*' $1)
iops_unit=$(echo $iops_result | grep -o 'k\|m')
iops=$(echo $iops_result | awk -F '=' '{print $2}')
if [ -n "$iops_unit" ]; then
  iops=$(echo $iops | awk '{sub("k","",$1); print $1*1000}')
fi

bw_result=$(grep -o 'BW=[0-9\ \.]*MiB/s\|BW=[0-9\ \.]*KiB/s' $1)
bw_unit=$(echo $bw_result | grep -o 'MiB/s\|KiB/s')
bw=$(echo $bw_result | grep -o '[0-9\ \.]*')
if [ $bw_unit == "KiB/s" ]; then
  bw=$(echo $bw | awk '{print $1/1000}')
fi

clat_result=$(grep "clat (msec)\|clat (usec)" $1)
clat_unit=$(echo $clat_result | awk -F ':' '{gsub(" ","",$1); print $1}')
clat=$(echo $clat_result | grep -o 'avg=[0-9\ \.]*' | awk -F '=' '{print $2}')
if [ $clat_unit == "clat(msec)" ]; then
  clat=$(echo $clat | awk '{print $1*1000}')
fi

echo -e $iops'\t'$bw'\t'$clat
